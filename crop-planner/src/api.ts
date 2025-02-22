import { Crop, Field } from "./types";

const SOIL_SERVICE_URL = "http://localhost:3000";

export const fetchFields = async (): Promise<Array<Field>> =>
  await fetch(`${SOIL_SERVICE_URL}/fields`).then((response) => response.json());

export const fetchCrops = async (): Promise<Array<Crop>> =>
  await fetch(`${SOIL_SERVICE_URL}/crops`).then((response) => response.json());

export const fetchHumusBalance = async (
  cropsValues: Array<number | undefined>
): Promise<number> =>
  (
    await fetch(
      `${SOIL_SERVICE_URL}/humus/balance?${cropsValues
        .map((value) => `crops_values[]=${value}`)
        .join("&")}`
    ).then((response) => response.json())
  ).balance;
