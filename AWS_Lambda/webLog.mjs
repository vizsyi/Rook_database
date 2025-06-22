import AWS from "aws-sdk";
const s3 = new AWS.S3();

const BUCKET_NAME = "log2025-06-s3";

const sources = ["prod", "dev"];

export const handler = async (event) => {
  if (event.requestContext?.http?.method === "OPTIONS") {
    return {
      statusCode: 200,
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "GET,OPTIONS",
        "Access-Control-Allow-Headers": "*",
      },
      body: "",
    };
  }

  const timestamp = Date.now();

  const params = event.queryStringParameters || {};
  let source = params.sou || "",
    action = params.act || "",
    content = params.cont || "";

  if (!source || !action || !sources.includes(source)) {
    //  || !action || !content || !sources.includes(source)
    content = `${source}, ${action}, ${content}`;
    action = "SAC"; //event.requestContext?.http?.method;
    source = "error";
  }

  const file_name = `raw/${source}-${timestamp}.txt`,
    bodyContent = `${source}, ${new Date(
      timestamp
    ).toISOString()}, ${action}, ${content}`;

  const objToPut = {
    Bucket: BUCKET_NAME,
    Key: file_name,
    Body: bodyContent,
    ContentType: "text/plain",
  };

  try {
    await s3.putObject(objToPut).promise();

    const response = {
      statusCode: 200,
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        message: "Ok!",
        //input: event.requestContext,
        //input: process.env,
      }),
    };
    return response;
  } catch (error) {
    return {
      statusCode: 500,
      body: JSON.stringify({
        message: "Error",
        error: error.message,
      }),
    };
  }
};
