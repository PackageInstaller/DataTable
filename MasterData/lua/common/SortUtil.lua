local WU, DB = require("Common/WindowUtil")()
local U = require("Common/Util")
local PB = require("Common/PbHelper")
local HU = require("Common/HtmlUtil")
local DBH = require("Manager/DataBindingHandler")
local SU = {
  DisplayOption = {
    name = 1,
    group = 2,
    equip = 3,
    arm = 4
  },
  DisplayNumbers = {
    Cultivation = {
      20,
      35,
      51
    },
    Speed = {
      21,
      36,
      52
    },
    Star = {
      3,
      34,
      50
    }
  }
}
local Type2DataBinding = {
  [PB.enum.SortType.Actor] = "fci/actor/",
  [PB.enum.SortType.Equip] = "fci/equip/",
  [PB.enum.SortType.Item] = "fci/item/",
  [PB.enum.SortType.Guild] = "fci/guild-recommend/",
  [PB.enum.SortType.CollectionsActor] = "Collections/Actors",
  [PB.enum.SortType.RoleNotepad] = "fci/RoleNotePad/",
  [PB.enum.SortType.MazeActor] = "fci/mazeactor",
  [PB.enum.SortType.Medal] = "fci/medal/",
  [PB.enum.SortType.TowerNew] = "fci/extreme-challenge/select-actors/",
  [PB.enum.SortType.Arm] = "fci/arms/",
  [PB.enum.SortType.GuildHelper] = "DungeonGuild/RentActors",
  [PB.enum.SortType.Friend] = "fci/friendlist/"
}
local Type2Function = {
  [PB.enum.SortType.Actor] = DBH.AppendActorInfo,
  [PB.enum.SortType.Equip] = DBH.AppendEquipInfo,
  [PB.enum.SortType.Item] = DBH.AppendItemInfo
}
local Type2NewField = {
  [PB.enum.ResourceType.ResActor] = {
    fieldName = "isNewCard",
    fieldIdOrUid = "uid",
    sortType = PB.enum.SortType.Actor
  },
  [PB.enum.ResourceType.ResEquip] = {
    fieldName = "isNew",
    fieldIdOrUid = "uid",
    sortType = PB.enum.SortType.Equip
  },
  [PB.enum.ResourceType.ResItem] = {
    fieldName = "isNew",
    fieldIdOrUid = "id",
    sortType = PB.enum.SortType.Item
  },
  [PB.enum.ResourceType.ResMedal] = {
    fieldName = "isNew",
    fieldIdOrUid = "id",
    sortType = PB.enum.SortType.Medal
  }
}

function merge_sort_recursive(src, tar, bg, ed, sortFunc)
  if ed <= bg then
    return
  end
  local len = ed - bg
  local mid = (len >> 1) + bg
  local bg1 = bg
  local ed1 = mid
  local bg2 = mid + 1
  local ed2 = ed
  merge_sort_recursive(src, tar, bg1, ed1, sortFunc)
  merge_sort_recursive(src, tar, bg2, ed2, sortFunc)
  local k = bg
  while bg1 <= ed1 and bg2 <= ed2 do
    if sortFunc(src[bg1], src[bg2]) then
      tar[k] = src[bg1]
      bg1 = bg1 + 1
    else
      tar[k] = src[bg2]
      bg2 = bg2 + 1
    end
    k = k + 1
  end
  while ed1 >= bg1 do
    tar[k] = src[bg1]
    bg1 = bg1 + 1
    k = k + 1
  end
  while ed2 >= bg2 do
    tar[k] = src[bg2]
    k = k + 1
    bg2 = bg2 + 1
  end
  for k = bg, ed do
    src[k] = tar[k]
  end
end

function SU.MergeSort(tb, sortFunc)
  local tmp = {}
  merge_sort_recursive(tb, tmp, 1, #tb, sortFunc)
end

function SU.CopyData(type)
  local sortData = _ENV["!"]({})
  local srcData = DB:GetData(Type2DataBinding[type])
  AppendExtraInfo(srcData, type)
  if srcData == nil then
    error("Sort", "SortType " .. type .. " source data is nil!")
  else
    table.copy(srcData, sortData)
  end
  return sortData
end

function AppendExtraInfo(list, type)
  local func = Type2Function[type]
  if func then
    local needAppend = false
    for i = 1, #list do
      if not list[i].extraInfoAppended then
        needAppend = true
      end
    end
    if needAppend then
      for i = 1, #list do
        func(list[i])
      end
    end
  end
end

function SU.ApplyFilters(list, filters)
  if filters == nil then
    return list
  end
  local kind = filters.kind
  local tags1 = filters.tags1
  local tags2 = filters.tags2
  local resultList = {}
  table.copy(list, resultList)
  for i = #resultList, 1, -1 do
    local data = resultList[i]
    local actorTags = PB.get("ActorTag", data.id)
    local tagTable = {}
    if actorTags == nil then
      warning("ActorTags.xlsx", "Can't find id :" .. tostring(data.id))
    else
      tagTable = actorTags.tag
    end
    local continue = false
    if not continue and tags1 ~= 0 and table.empty(table.select(tagTable, function(v)
      return fif(v == tags1, v, nil)
    end)) then
      table.remove(resultList, i)
      continue = true
    end
    if not continue and tags2 ~= 0 and table.empty(table.select(tagTable, function(v)
      return fif(v == tags2, v, nil)
    end)) then
      table.remove(resultList, i)
      continue = true
    end
    if not continue and kind ~= 0 and data.kind ~= kind then
      table.remove(resultList, i)
    end
  end
  return resultList
end

function SU.SortOnce(list, xlsx, reverse)
  if xlsx.algorithm == 1 then
    table.sort(list, function(a, b)
      return SortFuncByKey(a, b, xlsx.keys, reverse)
    end)
  else
    SU.MergeSort(list, function(a, b)
      return SortFuncByKey(a, b, xlsx.keys, reverse)
    end)
  end
end

function SortFuncByKey(a, b, keys, reverse)
  local envReverse = reverse
  for i = 1, #keys do
    local key = keys[i].keyName
    local param = keys[i].param
    if param == 1 then
      reverse = true
    elseif param == 2 then
      reverse = false
    end
    if a[key] and b[key] then
      if a[key] < b[key] then
        return not reverse
      else
        if a[key] > b[key] then
          return reverse
        else
        end
      end
    end
    reverse = envReverse
  end
end

function SU.SortByXlsxData(xlsxData, reverse)
  if xlsxData == nil then
    error("Sort", "SortTable failed : xlsxData is nil !")
    return
  end
  local list = SU.CopyData(xlsxData.type)
  SU.SortOnce(list, xlsxData, reverse)
  return list
end

function SU.GetXlsxSortData(sortmate)
  local xlsxData = _ENV["!"]({})
  if sortmate.ids.Count == 0 then
    return xlsxData
  end
  for i = 0, sortmate.ids.Count - 1 do
    local row = PB.get("Sort", sortmate.ids[i])
    if row ~= nil and row.type == U.ToInt(sortmate.type) then
      table.insert(xlsxData, row)
    end
  end
  return xlsxData
end

function SU.ClearNewFlag(type, list)
  if list == nil or table.empty(list) then
    return
  end
  local resInfo = {}
  local fieldInfo = Type2NewField[type]
  for i = 1, #list do
    if list[i][fieldInfo.fieldName] then
      table.insert(resInfo, {
        idOrUid = list[i][fieldInfo.fieldIdOrUid],
        type = type
      })
    end
  end
  if 0 < #resInfo then
    local patchData = {resInfo = resInfo, isNew = false}
    local wireFormat = ProtobufT("ApiResourceNewFlag", patchData)
    DB:GameRequest("fci/new-flag/"):Patch(wireFormat, function(result)
      local uri = Type2DataBinding[fieldInfo.sortType]
      for i = 1, #list do
        list[i][fieldInfo.fieldName] = false
        list[i].orderNew = 0
        DB:SetData(uri .. list[i][fieldInfo.fieldIdOrUid], list[i])
      end
      local dataSet = DB:GetData(uri)
      DB:SetData(uri, dataSet)
      local currentSortMate = DB:GetData("SortMate/Current")
      if currentSortMate ~= nil then
        DB:BroadcastGameEvent("ApplySortAlternativeRemainFilters", currentSortMate.tabIndex, currentSortMate.reverse)
      end
    end)
  end
end

function SU.OnActorClassify(actors)
  local main = {}
  local sub = {}
  if actors ~= nil then
    for i = 1, #actors do
      local actorConfig = PB.get("ActorConfig", actors[i].id)
      if actorConfig then
        if actorConfig.kind == PB.enum.ActorType.Main then
          table.insert(main, actors[i])
        elseif actorConfig.kind == PB.enum.ActorType.Sub then
          table.insert(sub, actors[i])
        end
      end
    end
  end
  return main, sub
end

return SU
