local RandomItemManager = {}
local _randomItems = {}
RandomItemManager.Type = {
  Mana = 1,
  RecoverShrine = 2,
  ManaCollector = 3
}
local RandomItemType = {
  [1] = require("logic.scene.types.randomitems.mana"),
  [2] = require("logic.scene.types.randomitems.recovershrine"),
  [3] = require("logic.scene.types.randomitems.manacollector")
}

function RandomItemManager.CreateRandomItem(data, ...)
  local record = BeanManager.GetTableByName("scene.cscenerandomreward"):GetRecorder(data.id)
  local item
  if record.type == RandomItemManager.Type.Mana then
    item = RandomItemType[1].Create(data)
  elseif record.type == RandomItemManager.Type.RecoverShrine then
    item = RandomItemType[2].Create(data, ...)
  elseif record.type == RandomItemManager.Type.ManaCollector then
    item = RandomItemType[3].Create(data)
  else
    LogError("RandomItemManager", "new type for cscenerandomreward with id " .. data.id)
  end
  if _randomItems[data.key] then
    LogError("RandomItemManager", "there is randomItem with key " .. data.key .. " exist")
    item:Destroy(true)
    item = nil
  else
    _randomItems[data.key] = item
  end
  return item
end

function RandomItemManager.RemoveRandomItem(key, controller)
  local seqEffect = _randomItems[key]:Destroy(false, controller)
  _randomItems[key] = nil
  return seqEffect
end

function RandomItemManager.GetRandomItem(key)
  return _randomItems[key]
end

function RandomItemManager.GetRandomItems()
  return _randomItems
end

function RandomItemManager.DestroyRandomItems()
  for _, v in pairs(_randomItems) do
    v:Destroy(true)
  end
  _randomItems = {}
end

function RandomItemManager.GetRandomItemPosListByType(type)
  local posList = {}
  for _, v in pairs(_randomItems) do
    if v:GetType() == type then
      local x, y = v:GetGirdPosition()
      table.insert(posList, {
        key = v:GetKey(),
        x = x,
        y = y
      })
    end
  end
  return posList
end

return RandomItemManager
