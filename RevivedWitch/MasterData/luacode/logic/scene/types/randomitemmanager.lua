-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/types/randomitemmanager.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local RandomItemManager = {}
local _randomItems = {}
RandomItemManager.Type = {Mana = 1, RecoverShrine = 2, ManaCollector = 3}
local RandomItemType = {[1] = require("logic.scene.types.randomitems.mana"), [2] = require("logic.scene.types.randomitems.recovershrine"), [3] = require("logic.scene.types.randomitems.manacollector")}
RandomItemManager.CreateRandomItem = function(data, ...)
  -- function num : 0_0 , upvalues : _ENV, RandomItemManager, RandomItemType, _randomItems
  (((BeanManager.GetTableByName)("scene.cscenerandomreward")):GetRecorder(data.id))
  local record = nil
  local item = nil
  if record.type == (RandomItemManager.Type).Mana then
    item = ((RandomItemType[1]).Create)(data)
  else
    if record.type == (RandomItemManager.Type).RecoverShrine then
      item = ((RandomItemType[2]).Create)(data, ...)
    else
      if record.type == (RandomItemManager.Type).ManaCollector then
        item = ((RandomItemType[3]).Create)(data)
      else
        LogError("RandomItemManager", "new type for cscenerandomreward with id " .. data.id)
      end
    end
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

RandomItemManager.RemoveRandomItem = function(key, controller)
  -- function num : 0_1 , upvalues : _randomItems
  local seqEffect = (_randomItems[key]):Destroy(false, controller)
  _randomItems[key] = nil
  return seqEffect
end

RandomItemManager.GetRandomItem = function(key)
  -- function num : 0_2 , upvalues : _randomItems
  return _randomItems[key]
end

RandomItemManager.GetRandomItems = function()
  -- function num : 0_3 , upvalues : _randomItems
  return _randomItems
end

RandomItemManager.DestroyRandomItems = function()
  -- function num : 0_4 , upvalues : _ENV, _randomItems
  for _,v in pairs(_randomItems) do
    v:Destroy(true)
  end
  _randomItems = {}
end

RandomItemManager.GetRandomItemPosListByType = function(type)
  -- function num : 0_5 , upvalues : _ENV, _randomItems
  local posList = {}
  for _,v in pairs(_randomItems) do
    if v:GetType() == type then
      local x, y = v:GetGirdPosition()
      ;
      (table.insert)(posList, {key = v:GetKey(), x = x, y = y})
    end
  end
  return posList
end

return RandomItemManager

