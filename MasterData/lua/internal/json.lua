local rapidjson = require("rapidjson")

function JsonD(json)
  if json ~= nil then
    local the_type = type(json)
    if the_type == "string" then
      return rapidjson.decode(json)
    elseif the_type == "table" then
      return json
    end
  end
end

function JsonE(data)
  if data ~= nil then
    local the_type = type(data)
    if the_type == "table" then
      return rapidjson.encode(data)
    elseif the_type == "string" then
      return data
    end
  end
end

return {
  JsonD,
  JsonE
}
