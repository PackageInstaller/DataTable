local WU, DB = require("Common/WindowUtil")()
local PB = require("Common/PbHelper")
local IU = require("Common/ItemUtil")
local RU = require("Common/RedMarkUtil")
local AU = require("Common/ActorUtil")
local NU = require("Common/NotepadUtil")
local EA = require("Common/EquipAttr")
local U = require("Common/Util")
local DBM = require("Common/Singleton"):Get("DataBindingManager")
local DBH = {}

function DBH.AppendActorInfo(actor, skipCultivation)
  if actor and not table.empty(actor) and actor.id > 0 then
    if not skipCultivation then
      actor.cultivationTotal = AU.GetActorCultivationDegree(actor)
    end
    actor.speed = U.GetAttrValue(actor.attrs, PB.enum.AttrType.Speed)
    actor.orderNew = fif(actor.isNewCard, 1, 0)
    actor.actorName = WU.GetString("ActorNameEn_" .. actor.id)
    local actorConfig = PB.get("ActorConfig", actor.id)
    if actorConfig == nil then
      warning("ActorConfig.xlsx", "id not found : " .. tostring(actor.id))
    else
      actor.kind = actorConfig.kind
      actor.role = actorConfig.role
    end
    local showArm = PB.all("Misc"):first().weaponMisc.weaponShowLevel
    if showArm <= actor.level then
      DB:SetData("Arm/ArmUnlock", true)
    end
  end
end

function DBH.AppendEquipInfo(equip)
  if equip and not table.empty(equip) then
    local equipInfo = PB.get("EquipInfo", equip.id)
    if equipInfo == nil then
      warning("EquipInfo.xlsx", "Can't find id " .. tostring(equip.id))
    else
      equip.quality = equipInfo.quality
      equip.position = equipInfo.pos
      equip.orderNew = fif(equip.isNew, 1, 0)
      equip.equipOn = fif(equip.actorUid ~= 0, 1, 0)
      equip.requireLevel = equipInfo.requireLevel
      equip.score = EA.GetEquipScore(equip)
      equip.AttackRate = 0
      equip.HpRate = 0
      equip.PhysicalDefenseRate = 0
      equip.MagicalDefenseRate = 0
      equip.CriticalHitRate = 0
      equip.CriticalHitDamageRate = 0
      local equipRandomAttr = EA.GetRandAttrMapByEquip(equip)
      if equipRandomAttr then
        do
          local function func(type)
            local key = PB.enum.AttrType.__keys[type]
            
            if equipRandomAttr[type] then
              for k, v in pairs(equipRandomAttr[type]) do
                equip[key] = equip[key] + v.value
              end
            end
          end
          
          func(PB.enum.AttrType.AttackRate)
          func(PB.enum.AttrType.HpRate)
          func(PB.enum.AttrType.PhysicalDefenseRate)
          func(PB.enum.AttrType.MagicalDefenseRate)
          func(PB.enum.AttrType.CriticalHitRate)
          func(PB.enum.AttrType.CriticalHitDamageRate)
        end
      end
    end
  end
end

function DBH.AppendItemInfo(item)
  if item and not table.empty(item) then
    local itemInfo = PB.get("ItemInfo", item.id)
    if itemInfo == nil then
      warning("ItemInfo.xlsx", "Can't find id " .. tostring(item.id))
      return false
    else
      item.quality = itemInfo.quality
      item.exp = itemInfo.param[1] or 0
      item.funcType = itemInfo.funcType
      item.orderNew = fif(item.isNew, 1, 0)
      return true
    end
  end
end

function DBH.AppendArmInfo(arm)
  if arm and not table.empty(arm) then
    arm.level = 0
    setmetatable(arm, {
      __index = PB.get("UniqueWeaponInfo", arm.id)
    })
    arm.attrs = {}
    local attrLevelCnt = 0
    local attrList = {}
    local speAttrList = {}
    arm.speAttr.special = true
    table.insert(arm.baseAttrs, arm.speAttr)
    local attrArr = _ENV["!"](arm.baseAttrs):toarray()
    for k, v in pairs(attrArr) do
      local attrInfo = PB.get("UniqueWeaponAttrEnhanceInfo", v.attrId, v.level)
      if attrInfo then
        for key, val in pairs(attrInfo.attr) do
          if arm.attrs[val.type] then
            arm.attrs[val.type].value = math.abs(arm.attrs[val.type].value) + math.abs(val.value)
          else
            arm.attrs[val.type] = {
              type = val.type,
              value = math.abs(val.value),
              isRatio = val.isRatio
            }
          end
          arm.level = arm.level + v.level
          local valCopy = {}
          table.copy(val, valCopy)
          if valCopy.value then
            valCopy.value = math.abs(valCopy.value)
          else
            valCopy.value = 0
          end
          local pattern = {
            attrId = v.attrId,
            level = v.level,
            attr = {
              type = valCopy.type,
              value = U.FormatAttrValue(valCopy),
              isRatio = valCopy.isRatio
            },
            special = v.special
          }
          table.insert(attrList, pattern)
          if v.special then
            table.insert(speAttrList, pattern)
            local attrInfos = PB.all("UniqueWeaponAttrEnhanceInfo"):where(function(index, attr)
              return v.attrId == attr.attrId
            end):toarray()
            if attrInfos then
              arm.maxSpeAttrLevel = #attrInfos - 1
            end
          end
        end
      else
        warning("UniqueWeaponAttrEnhanceInfo.xlsx", "Can't find attr id: " .. v.attrId .. " level: " .. v.level)
        return false
      end
    end
    table.sort(attrList, function(a, b)
      return a.attrId < b.attrId
    end)
    arm.baseAttrs = attrList
    arm.speAttr = speAttrList
    arm.attrs = table.toarray(arm.attrs)
    local ac = DB:GetData("fci/actor/" .. arm.actorUid)
    if ac then
      arm.actorId = ac.id
    end
    arm.phase = arm.phase - 1
    local weaponMisc = PB.all("Misc"):first().weaponMisc
    arm.maxPhase = U.ToInt(weaponMisc.weaponMaxPhase) - 1
    arm.maxAttrLevel = 50
    local attrLevelInfo = PB.get("UniqueWeaponAscend", arm.quality, arm.phase + 1)
    if attrLevelInfo then
      arm.maxAttrLevel = attrLevelInfo.levelLimit
    end
    local allAscend = PB.all("UniqueWeaponAscend"):where(function(k, v)
      return v.quality == arm.quality
    end):toarray()
    table.sort(allAscend, function(a, b)
      return a.levelLimit < b.levelLimit
    end)
    arm.finalAttrLv = allAscend[#allAscend].levelLimit
    arm.currentSkill = {}
    setmetatable(arm.currentSkill, {
      __index = PB.get("UniqueWeaponSkill", arm.id, arm.phase + 1)
    })
    arm.name = WU.GetString("UniqueWeaponName_" .. arm.id)
    arm.cultivation = tonumber(string.format("%.0f", AU.GetCultivationDegreeArm(arm) + AU.GetCultivationDegreeAttr(arm.attrs)))
    return true
  end
end

function DBH.UpdateActors(changes)
  if changes and not _ENV["!"](changes):empty() then
    if #changes == 0 then
      changes = {changes}
    end
    local changedEquips = {}
    local actors = DB:GetData("fci/actor/")
    local groupActorUids = DB:GetData("GroupActorUids")
    local newActorIds = {}
    local hasActorStarLevelup = false
    local hasActorNew = false
    local hasActorRemoved = false
    for _, change in pairs(changes) do
      if 0 < change.countDelta then
        DBH.AppendActorInfo(change)
        DB:SetData("fci/actor/" .. change.uid, change)
        actors[#actors + 1] = change
        hasActorStarLevelup = true
        table.insert(newActorIds, change.id)
        hasActorNew = true
        DB:SetData("ActorIDSet", nil)
      elseif 0 > change.countDelta then
        local actor = DB:GetData("fci/actor/" .. change.uid)
        for _, equipUid in pairs(actor.bodyEquips) do
          local equip = DB:GetData("fci/equip/" .. equipUid)
          if equip then
            equip.actorUid = 0
            changedEquips[#changedEquips + 1] = equip
          end
        end
        DB:SetData("fci/actor/" .. change.uid, nil)
        table.remove(actors, table.find(actors, function(_, actor)
          return actor.uid == change.uid
        end))
        hasActorRemoved = true
        DB:SetData("ActorIDSet", nil)
      else
        DBH.AppendActorInfo(change)
        if not hasActorStarLevelup and change.star > DB:GetData("fci/actor/" .. change.uid).star then
          hasActorStarLevelup = true
        end
        DB:SetData("fci/actor/" .. change.uid, change)
        actors[table.find(actors, function(_, actor)
          return actor.uid == change.uid
        end)] = change
      end
      if groupActorUids and 0 <= change.countDelta then
        for key, val in pairs(change.groupTag) do
          local rec = groupActorUids[change.uid]
          groupActorUids[change.uid] = (rec or 0) | 1 << tonumber(key) - 1
        end
      end
    end
    DB:SetData("GroupActorUids", groupActorUids)
    DBH.UpdateEquips(changedEquips)
    DB:SetData("fci/actor/", actors)
    if hasActorNew then
      DB:BroadcastGameEvent("ActorNew")
    end
    if hasActorRemoved then
      DB:BroadcastGameEvent("ActorRemoved")
    end
    if hasActorStarLevelup then
      DB:BroadcastGameEvent("HasActorStarLevelup")
    end
    if 0 < #newActorIds then
      NU.GetCollectionsActor(function()
        local owed = true
        for i = 1, #newActorIds do
          if not NU.AlreadyOwedActor(newActorIds[i]) then
            owed = false
            break
          end
        end
        if not owed then
          DB:BroadcastGameEvent("HasNewActors")
        end
      end)
    end
  end
end

function DBH.UpdateEquips(changes)
  if changes and not _ENV["!"](changes):empty() then
    if #changes == 0 then
      changes = {changes}
    end
    local changedActors = {}
    local hasEquipNew = false
    local hasEquipRemoved = false
    local equips = DB:GetData("fci/equip/")
    for _, change in pairs(changes) do
      if 0 < change.countDelta then
        DBH.AppendEquipInfo(change)
        DB:SetData("fci/equip/" .. change.uid, change)
        equips[#equips + 1] = change
        DBH.UpdateEquipMinRequireLevelMap(change)
        hasEquipNew = true
      elseif 0 > change.countDelta then
        local equip = DB:GetData("fci/equip/" .. change.uid)
        local actor = DB:GetData("fci/actor/" .. equip.actorUid)
        if actor then
          local equipInfo = PB.get("EquipInfo", equip.id)
          if equipInfo then
            actor.bodyEquips[tostring(equipInfo.pos)] = nil
          end
          changedActors[#changedActors + 1] = actor
        end
        DB:SetData("fci/equip/" .. change.uid, nil)
        local index = table.find(equips, function(_, equip)
          return equip.uid == change.uid
        end)
        if index then
          table.remove(equips, index)
          DBH.UpdateEquipMinRequireLevelMap(equip)
        end
        hasEquipRemoved = true
      else
        DBH.AppendEquipInfo(change)
        DB:SetData("fci/equip/" .. change.uid, change)
        local index = table.find(equips, function(_, equip)
          return equip.uid == change.uid
        end)
        if index then
          equips[index] = change
          DBH.UpdateEquipMinRequireLevelMap(change)
        end
      end
    end
    DBH.UpdateActors(changedActors)
    DB:SetData("fci/equip/", equips)
    if hasEquipNew then
      DB:BroadcastGameEvent("EquipNew")
    end
    if hasEquipRemoved then
      DB:BroadcastGameEvent("EquipRemoved")
    end
  end
end

function DBH.UpdateArms(changes)
  if changes and not _ENV["!"](changes):empty() then
    if #changes == 0 then
      changes = {changes}
    end
    local changedActors = {}
    local arms = DB:GetData("fci/arms/")
    for _, change in pairs(changes) do
      DBH.AppendArmInfo(change)
      DB:SetData("fci/arms/" .. change.id, change)
      local index = table.find(arms, function(_, arm)
        return change.id == arm.id
      end)
      if 0 < change.countDelta then
        table.insert(arms, change)
      elseif 0 > change.countDelta then
        if index then
          table.remove(arms, index)
        end
      elseif index then
        arms[index] = change
      end
    end
    table.sort(arms, function(a, b)
      return a.id < b.id
    end)
    DB:SetData("fci/arms/", arms)
  end
end

function DBH.UpdateItems(changes)
  if changes and not _ENV["!"](changes):empty() then
    if #changes == 0 then
      changes = {changes}
    end
    local items = DB:GetData("fci/item/")
    local hasItemNew = false
    local hasItemRemoved = false
    for _, change in pairs(changes) do
      local item = DB:GetData("fci/item/" .. change.id)
      if item ~= nil then
        _ENV["!"](item):merge(change)
        if item.historyGetCount then
          if change.countDelta and 0 < change.countDelta then
            item.historyGetCount = item.historyGetCount + change.countDelta
          end
        else
          local config = PB.get("ItemInfo", change.id)
          if config and config.dropMaxCount and 0 < config.dropMaxCount then
            item.historyGetCount = change.count
          end
        end
        if item.count == 0 then
          hasItemRemoved = true
        end
      else
        item = {
          count = change.count,
          expireTime = 0,
          id = change.id,
          gotTime = CS.GameTime.serverUtc,
          isNew = true
        }
        local config = PB.get("ItemInfo", change.id)
        if config and config.dropMaxCount and 0 < config.dropMaxCount then
          item.historyGetCount = change.count
        end
        hasItemNew = true
      end
      DBH.AppendItemInfo(item)
      DB:SetData("fci/item/" .. change.id, item)
      local index = table.find(items, function(_, v)
        return v.id == change.id
      end)
      items[index or #items + 1] = item
      local itemInfo = PB.get("ItemInfo", change.id)
    end
    DB:SetData("fci/item/", items)
    if hasItemNew then
      DB:BroadcastGameEvent("ItemNew")
    end
    if hasItemRemoved then
      DB:BroadcastGameEvent("ItemRemoved")
    end
  end
end

function DBH.UpdateHeadPhoto(photo)
  local photos = DB:GetData("fci/headphoto/")
  if photos == nil then
    return
  end
  DBH.DBUpdate(photos, "id", photo)
  DB:SetData("fci/headphoto/", photos)
end

function DBH.UpdateHeadFrame(frame)
  local frames = DB:GetData("fci/headframe/")
  if frames == nil then
    return
  end
  local isGot = false
  for i = 1, #frames do
    if frames[i].id == frame.id then
      frames[i].expireTime = frames[i].expireTime + frame.expireDay * 86400
      isGot = true
      break
    end
  end
  if not isGot then
    local frameInfo = {}
    frameInfo.id = frame.id
    frameInfo.expireTime = CS.GameTime.serverUtc + frame.expireDay * 86400
    frameInfo.gotTime = CS.GameTime.serverUtc
    frameInfo.isNew = true
    DBH.DBUpdate(frames, "id", frameInfo)
  end
  DB:SetData("fci/headframe/", frames)
end

function DBH.UpdateEmoji(emoji)
  local emojiAll = DB:GetData("fci/emoji/")
  if emojiAll == nil then
    return
  end
  DBH.DBUpdate(emojiAll, "id", emoji)
  DB:SetData("fci/emoji/", emojiAll)
end

function DBH.UpdateMedal(medalId)
  local all = DB:GetData("fci/medal/")
  if all ~= nil then
    table.insert(all, {
      id = medalId,
      isNew = true,
      gotTime = CS.GameTime.serverUtc
    })
    DB:SetData("fci/medal/", all)
  end
end

function DBH.UpdateActorSkin(skinId)
  local skinIds = DB:GetData("fci/unlockedSkins/")
  local newSkinIds = DB:GetData("fci/newSkins/")
  if skinIds ~= nil then
    skinIds[skinId] = true
    DB:SetData("fci/unlockedSkins/", skinIds)
  end
  if newSkinIds ~= nil then
    newSkinIds[skinId] = true
    DB:SetData("fci/newSkins/", newSkinIds)
  end
end

function DBH.UpdateSignboard(id)
  local unlockedSignboard = DB:GetData("BoardActor/AllUnlocked")
  if unlockedSignboard == nil then
    unlockedSignboard = _ENV["!"]({})
  end
  table.insert(unlockedSignboard, id)
  DB:SetData("BoardActor/AllUnlocked", unlockedSignboard)
end

function DBH.UpdateBaseRes(baseRes)
  DB:SetData("fci/resource/" .. PB.enum.ResourceType.__keys[baseRes.type] .. "_" .. baseRes.id, baseRes.count)
end

function DBH.UpdateProfit(baseRes)
end

function DBH.RelationApplylistRemove(playerInfo)
  DB:SetData("fci/applylist/" .. playerInfo.playerId, nil)
  local applylist = DB:GetData("fci/applylist/")
  DBH.DBRemove(applylist, "playerId", playerInfo.playerId)
  DB:SetData("fci/applylist/", applylist)
end

function DBH.RelationFriendlistChange(playerInfo)
  DB:SetData("fci/friendlist/" .. playerInfo.playerId, playerInfo)
  local friendlist = DB:GetData("fci/friendlist/")
  DBH.DBUpdate(friendlist, "playerId", playerInfo)
  DB:SetData("fci/friendlist/", friendlist)
end

function DBH.RelationFriendlistRemove(playerId)
  DB:SetData("fci/friendlist/" .. playerId, nil)
  local friendlist = DB:GetData("fci/friendlist/")
  DBH.DBRemove(friendlist, "playerId", playerId)
  DB:SetData("fci/friendlist/", friendlist)
end

function DBH.RelationFriendlistRemoveBatch(ids)
  local players = DB:GetData("fci/friendlist/")
  for i = 1, #ids do
    DB:SetData("fci/friendlist/" .. ids[i], nil)
    DBH.DBRemove(players, "playerId", ids[i])
  end
  DB:SetData("fci/friendlist/", players)
end

function DBH.MailRemoveBatch(ids)
  local mails = DB:GetData("fci/mail/")
  for i = 1, #ids do
    DB:SetData("fci/mail/" .. ids[i], nil)
    DBH.DBRemove(mails, "id", ids[i])
  end
  DB:SetData("fci/mail/", mails)
end

function DBH.MailRemove(id)
  DB:SetData("fci/mail/" .. id, nil)
  local mails = DB:GetData("fci/mail/")
  DBH.DBRemove(mails, "id", id)
  DB:SetData("fci/mail/", mails)
end

function DBH.MailChange(mail)
  DB:SetData("fci/mail/" .. mail.id, mail)
  local mails = DB:GetData("fci/mail/") or _ENV["!"]({})
  DBH.DBUpdate(mails, "id", mail)
  CheckMailLimit(mails)
  DB:SetData("fci/mail/", mails)
end

function DBH.TriggeredEventChange(event)
  local triggeredEventData = DB:GetData("fci/triggered-event/")
  if triggeredEventData then
    DBH.DBUpdate(triggeredEventData.eventInfo, "eventKey", event)
    DB:SetData("fci/triggered-event/", triggeredEventData)
  end
end

function CheckMailLimit(mails)
  local misc = PB.all("Misc"):first()
  if #mails > misc.maxPlayerMail then
    table.sort(mails, function(a, b)
      return a.id < b.id
    end)
    local delCount = #mails - misc.maxPlayerMail
    while 0 < delCount do
      table.remove(mails, 1)
      delCount = delCount - 1
    end
  end
end

function DBH.RoleNotepadChange(notepad)
  DB:SetData("fci/RoleNotePad/" .. notepad.roleId, notepad)
  local notepads = DB:GetData("fci/RoleNotePad/")
  DBH.DBUpdate(notepads, "roleId", notepad)
  DB:SetData("fci/RoleNotePad/", notepads)
end

function DBH.DBUpdate(tb, key, val)
  DBM.DBUpdateImpl(tb, key, val)
end

function DBH.DBRemove(tb, key, keyVal)
  DBM.DBRemoveImpl(tb, key, keyVal)
end

function DBH.ResChange(resChange)
  resChange = IU.FlatInboxItems(resChange)
  if resChange then
    local changedActors = {}
    local changedEquips = {}
    local changedItems = {}
    local changedArms = {}
    for _, change in pairs(resChange) do
      if change.actor then
        changedActors[#changedActors + 1] = change.actor
      elseif change.equip then
        changedEquips[#changedEquips + 1] = change.equip
      elseif change.afterUpgradeWeapon then
        changedArms[#changedArms + 1] = change.afterUpgradeWeapon
      elseif change.weapon then
        changedArms[#changedArms + 1] = change.weapon
      elseif change.baseRes then
        if change.baseRes.type == PB.enum.ResourceType.ResItem then
          changedItems[#changedItems + 1] = change.baseRes
        elseif change.baseRes.type == PB.enum.ResourceType.ResPlayerHeadPhoto then
          DBH.UpdateHeadPhoto(PB.get("PlayerHeadPhoto", change.baseRes.id))
        elseif change.baseRes.type == PB.enum.ResourceType.ResPlayerHeadFrame then
          DBH.UpdateHeadFrame(PB.get("PlayerHeadFrame", change.baseRes.id))
        elseif change.baseRes.type == PB.enum.ResourceType.ResEmoji then
          DBH.UpdateEmoji({
            id = change.baseRes.id
          })
        elseif change.baseRes.type == PB.enum.ResourceType.ResMedal then
        elseif change.baseRes.type == PB.enum.ResourceType.ResActorSkin then
          DBH.UpdateActorSkin(change.baseRes.id)
        elseif change.baseRes.type == PB.enum.ResourceType.ResSignboard then
          DBH.UpdateSignboard(change.baseRes.id)
        elseif change.baseRes.type == PB.enum.ResourceType.ResProfit then
          DBH.UpdateProfit(change.baseRes.id)
        elseif change.baseRes.type == PB.enum.ResourceType.ResMazeHollow then
          DBH.UpdateHollow(change.baseRes)
        else
          DBH.UpdateBaseRes(change.baseRes)
        end
      end
    end
    DBH.UpdateItems(changedItems)
    DBH.UpdateActors(changedActors)
    DBH.UpdateEquips(changedEquips)
    DBH.UpdateArms(changedArms)
  end
end

function DBH.UpdateHollow(hollow)
  local allHollow = DB:GetData("fci/mazeHollow/")
  if allHollow == nil then
    allHollow = _ENV["!"]({})
  end
  local index = table.find(allHollow, function(k, v)
    return v.id == hollow.id
  end)
  if index then
    allHollow[index] = hollow
  else
    table.insert(allHollow, hollow)
  end
  DB:SetData("fci/mazeHollow/", allHollow)
end

function DBH.DBFirst(tb, key, keyVal, tarObj)
  local idx, val
  if key == nil then
    idx, val = table.find(tb, function(k, v)
      return v == keyVal
    end)
  else
    idx, val = table.find(tb, function(k, v)
      return v[key] == keyVal
    end)
  end
  if idx ~= nil then
    table.remove(tb, idx)
    table.insert(tb, 1, val)
  elseif tarObj ~= nil then
    table.insert(tb, 1, tarObj)
  else
    info("DataBinding", "DBH.DBFirst tarObj is nil")
  end
  return tb
end

function DBH.UpdateEquipMinRequireLevelMap(equip)
  local posMap = DB:GetData("equipMinRequireLevelPosMap")
  if posMap == nil then
    return
  end
  local equipInfo = PB.get("EquipInfo", equip.id)
  if equipInfo then
    local pos = equipInfo.pos
    local minEquip = posMap[pos]
    local hasChange = false
    if equip.countDelta >= 0 then
      if equip.actorUid == 0 then
        if minEquip == nil or equipInfo.requireLevel < minEquip.requireLevel then
          posMap[pos] = {
            uid = equip.uid,
            requireLevel = equipInfo.requireLevel
          }
          hasChange = true
        end
      elseif minEquip ~= nil and equip.uid == minEquip.uid then
        posMap[pos] = FindNewMinRequireLevelEquip(pos)
        hasChange = true
      end
    elseif minEquip ~= nil and equip.uid == minEquip.uid then
      posMap[pos] = FindNewMinRequireLevelEquip(pos)
      hasChange = true
    end
    if hasChange then
      DB:SetData("equipMinRequireLevelPosMap", posMap)
    end
  end
end

function FindNewMinRequireLevelEquip(pos)
  local minRecord
  local equipList = DB:GetData("fci/equip")
  if equipList ~= nil then
    for i = 1, #equipList do
      local equipInfo = PB.get("EquipInfo", equipList[i].id)
      if equipList[i].actorUid == 0 and equipInfo.pos == pos and (minRecord == nil or minRecord.requireLevel > equipInfo.requireLevel) then
        minRecord = {
          uid = equipList[i].uid,
          requireLevel = equipInfo.requireLevel
        }
      end
    end
  end
  return minRecord
end

return DBH
