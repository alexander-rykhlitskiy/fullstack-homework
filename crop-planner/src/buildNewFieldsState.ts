import { Crop, Field } from './types'
import { filter, find } from 'lodash'
import { fetchHumusBalance } from './api'

// Here we emulate a reducer
const buildNewFieldsState = (oldFields: Array<Field>, newCrop: Crop | null, fieldId: number, cropYear: number) => {
  const oldField = find(oldFields, field => field.id === fieldId)!

  return {
    fields: [
      ...filter(oldFields, field => field.id !== fieldId),
      {
        ...oldField,
        crops: [
          ...filter(oldField.crops, crop => crop.year !== cropYear),
          { year: cropYear, crop: newCrop },
        ],
      },
    ],
  }
}

const buildNewFieldsStateWithHumusBalance = async (fields: Array<Field>, fieldId: number) => {
  const field = find(fields, field => field.id === fieldId)!
  return {
    fields: [
      ...filter(fields, field => field.id !== fieldId),
      {
        ...field,
        humus_balance: await fetchHumusBalance(field.crops.map(crop => crop.crop?.value))
      }
    ]
  }
}

export { buildNewFieldsState as default, buildNewFieldsStateWithHumusBalance }
