local WU, DB = require("Common/WindowUtil")()
local U = require("Common/Util")
local PB = require("Common/PbHelper")
local HU = require("Common/HtmlUtil")
local TU = require("Common/TextUtil")
local SE = require("Common/SkillEffect")
local EA = require("Common/EquipAttr")
local EU = require("Common/EquipUtil")
local AU = {
  ActorColorTable = {
    [0] = 2359273727,
    [1] = 1153008383,
    [2] = 514322431,
    [3] = 3026376703,
    [4] = 4122612479,
    [5] = 4234043135
  },
  ActorQuality2Tag = {
    [0] = "D",
    [1] = "C",
    [2] = "B",
    [3] = "A",
    [4] = "S"
  },
  ActorAttrIndices = {
    PB.enum.AttrType.Hp,
    PB.enum.AttrType.Attack,
    PB.enum.AttrType.PhysicalDefense,
    PB.enum.AttrType.MagicalDefense,
    PB.enum.AttrType.CriticalHitRate,
    PB.enum.AttrType.CriticalHitDamageRate
  }
}
local m_chipId2RoleIdMap, m_roleId2ActorIdsMap

function AU.GetRoleIdByChipId(chipId)
  if not m_chipId2RoleIdMap then
    m_chipId2RoleIdMap = {}
    local roles = PB.all("Role")
    for _, role in pairs(roles) do
      m_chipId2RoleIdMap[role.decomposeRes.id] = role.id
    end
  end
  return m_chipId2RoleIdMap[chipId]
end

function AU.GetActorIdsByRoleId(roleId)
  if not m_roleId2ActorIdsMap then
    m_roleId2ActorIdsMap = {}
    local actorConfigs = PB.all("ActorConfig")
    for _, actorConfig in pairs(actorConfigs) do
      if not m_roleId2ActorIdsMap[actorConfig.role] then
        m_roleId2ActorIdsMap[actorConfig.role] = {}
      end
      table.insert(m_roleId2ActorIdsMap[actorConfig.role], actorConfig.id)
    end
  end
  return m_roleId2ActorIdsMap[roleId]
end

function AU.GetActorIdsByChipId(chipId)
  local roleId = AU.GetRoleIdByChipId(chipId)
  if roleId then
    return AU.GetActorIdsByRoleId(roleId)
  end
end

function AU.GenActorStarPromotionsAccumulated(actorId, quality, star, phase)
  local result = {}
  local actorInfo = PB.get("ActorInfo", actorId, quality)
  local resStarPhases = PB.index("Misc", 1).starPhases
  if actorInfo ~= nil then
    for s = 1, star do
      local lastPhase = fif(s == star, phase, resStarPhases[s])
      for p = 0, lastPhase do
        local promotion = PB.get("ActorAttrStarPromotion", actorId, s, p)
        if promotion then
          for _, attr in pairs(promotion.attrs) do
            if 0 < attr.type then
              local value = attr.value * actorInfo.qualityAttrRatio
              if not result[attr.type] then
                result[attr.type] = {
                  type = attr.type,
                  isRatio = attr.isRatio,
                  value = value
                }
              else
                result[attr.type].value = result[attr.type].value + value
              end
            end
          end
        else
          error("ActorUtil", "Cannot find ActorAttrStarPromotion with actorId " .. actorId .. " and star " .. s .. " and phase " .. p)
          break
        end
      end
    end
  else
    error("ActorUtil", "Cannot find ActorInfo with actorId " .. actorId .. " and quality " .. quality)
  end
  for _, v in pairs(result) do
    v.value = math.floor(v.value)
  end
  return result
end

function AU.GetQualityColorHex(quality)
  quality = quality or 0
  return AU.ActorColorTable[quality] or AU.ActorColorTable[0]
end

function AU.GetQualityColorStr(quality)
  return string.format("#%08X", AU.GetQualityColorHex(quality))
end

function AU.GenActorStarPromotions(actorId, quality, fromStar, toStar)
  local fromAttrPromotion = {}
  local toAttrPromotion = {}
  local deltaAttrPromotion = {}
  local actorInfo = PB.get("ActorInfo", actorId, quality)
  if actorInfo ~= nil then
    for s = 1, toStar do
      local promotion = PB.get("ActorAttrStarPromotion", actorId, s)
      if promotion then
        for _, attr in pairs(promotion.attrs) do
          if attr.type > 0 then
            local value = attr.value * actorInfo.qualityAttrRatio
            if s <= fromStar then
              if not fromAttrPromotion[attr.type] then
                fromAttrPromotion[attr.type] = {
                  type = attr.type,
                  isRatio = attr.isRatio,
                  value = value
                }
              else
                fromAttrPromotion[attr.type].value = fromAttrPromotion[attr.type].value + value
              end
            end
            if not toAttrPromotion[attr.type] then
              toAttrPromotion[attr.type] = {
                type = attr.type,
                isRatio = attr.isRatio,
                value = value
              }
            else
              toAttrPromotion[attr.type].value = toAttrPromotion[attr.type].value + value
            end
          end
        end
      else
        error("ActorUtil", "Cannot find ActorAttrStarPromotion with actorId " .. actorId .. " and star " .. s)
        break
      end
    end
  else
    error("ActorUtil", "Cannot find ActorInfo with actorId " .. actorId .. " and quality " .. quality)
  end
  for type, attr in pairs(toAttrPromotion) do
    local deltaValue = math.floor(attr.value)
    if fromAttrPromotion[type] then
      deltaValue = deltaValue - math.floor(fromAttrPromotion[type].value)
    end
    deltaAttrPromotion[type] = {
      type = type,
      isRatio = attr.isRatio,
      value = deltaValue
    }
  end
  return deltaAttrPromotion
end

function AU.GetActorLevelPromotion(actorId, quality, fromLevel, toLevel)
  local actorAttrLevelPromotion = PB.get("ActorAttrLevelPromotion", actorId)
  local maxLevel = AU.GetActorMaxLevel()
  local fromLevelFactor = (fromLevel - 1) / (maxLevel - 1)
  local toLevelFactor = (toLevel - 1) / (maxLevel - 1)
  local actorInfo = PB.get("ActorInfo", actorId, quality)
  local qualityFactor = actorInfo.qualityAttrRatio
  local deltaAttrs = {}
  for _, attr in ipairs(actorAttrLevelPromotion.attrs) do
    local deltaValue = math.floor(attr.value * (toLevelFactor - fromLevelFactor) * qualityFactor)
    table.insert(deltaAttrs, {
      type = attr.type,
      isRatio = attr.isRatio,
      value = deltaValue
    })
  end
  return deltaAttrs
end

function AU.GetActorMaxLevel()
  return PB.all("Misc"):first().maxActorLevel
end

function AU.IsLinked(actorA, actorB)
  if actorA.id == actorB.id then
    return false
  end
  local rows = PB.all("ActorLink")
  local linkTable = {}
  for i = 1, #rows do
    if U.IsTimeOpen(rows[i].openTime) then
      for li = 1, #rows[i].link do
        if rows[i].link[li].actorID == actorA.id then
          table.insert(linkTable, rows[i])
        end
      end
    end
  end
  for i = 1, #linkTable do
    for li = 1, #linkTable[i].link do
      if linkTable[i].link[li].actorID == actorB.id then
        return true
      end
    end
  end
  return false
end

function AU.GetActorLinks(actorInfo, actorPool)
  if actorInfo then
    local activeActors = {}
    for _, v in pairs(actorPool) do
      activeActors[v.id] = true
    end
    local rows = PB.all("ActorLink")
    local linkTable = {}
    for i = 1, #rows do
      for li = 1, #rows[i].link do
        if rows[i].link[li].actorID == actorInfo.id then
          table.insert(linkTable, rows[i])
        end
      end
    end
    linkTable = OpenActorFilter(linkTable)
    local activeLinkTable = {}
    for i = 1, #linkTable do
      local activeLink = true
      for li = 1, #linkTable[i].link do
        local linkActorId = linkTable[i].link[li].actorID
        if linkActorId ~= actorInfo.id and activeActors[linkActorId] == nil then
          activeLink = false
        end
      end
      if activeLink then
        table.insert(activeLinkTable, linkTable[i])
      end
    end
    return activeLinkTable, linkTable
  end
end

function AU.GetActorLinkInfo(actorId)
  local rows = PB.all("ActorLink")
  local linkInfo = {}
  for i = 1, #rows do
    for j = 1, #rows[i].link do
      if actorId == rows[i].link[j].actorID then
        table.insert(linkInfo, rows[i])
        break
      end
    end
  end
  linkInfo = OpenActorFilter(linkInfo)
  return linkInfo
end

function OpenActorFilter(linkInfo)
  for i = #linkInfo, 1, -1 do
    local flag = false
    local linkTab = PB.get("ActorLink", linkInfo[i].linkID)
    if not U.IsTimeOpen(linkTab.openTime) then
      flag = true
    else
      for j = 1, #linkTab.link do
        local actorConfig = PB.get("ActorConfig", linkTab.link[j].actorID)
        local openTime = actorConfig.openTime
        if not AU.IsActorOpen(linkTab.link[j].actorID, openTime) then
          flag = true
          break
        end
      end
    end
    if flag then
      table.remove(linkInfo, i)
    end
  end
  return linkInfo
end

function AU.SetPlayerName(go, accountCache, baseInfo)
  if baseInfo.name == "" then
    local prefix = WU.GetString("WindowLogin_Player")
    if accountCache.entryType == "guest" then
      prefix = WU.GetString("WindowLogin_Guest")
    end
    go.UILabel.text = string.gsub(accountCache.openId, "fci_", prefix)
  else
    go.UILabel.text = baseInfo.name
  end
end

function AU.GetItems(itemType, sortFunc, dontCnt)
  local result = {}
  local data = PB.all("ItemInfo")
  for index = 1, #data do
    local resItemInfo = data[index]
    if not itemType or resItemInfo.funcType == itemType then
      if dontCnt then
        table.insert(result, {itemInfo = resItemInfo})
      else
        local cnt = DB:GetData("fci/item/" .. resItemInfo.id).count
        if 0 < cnt then
          table.insert(result, {cnt = cnt, itemInfo = resItemInfo})
        end
      end
    end
  end
  if sortFunc and type(sortFunc) == "function" then
    table.sort(result, sortFunc)
  end
  return result
end

function AU.OnActorClassify(actorInfoRaws, windowName)
  if windowName == nil then
    windowName = ""
  end
  local main = {}
  local sub = {}
  local all = {}
  if actorInfoRaws ~= nil then
    for i = 1, #actorInfoRaws do
      local actorConfig = PB.get("ActorConfig", actorInfoRaws[i].id)
      if actorConfig then
        if actorConfig.kind == PB.enum.ActorType.Main then
          table.insert(main, actorInfoRaws[i])
        elseif actorConfig.kind == PB.enum.ActorType.Sub then
          table.insert(sub, actorInfoRaws[i])
        end
        table.insert(all, actorInfoRaws[i])
      end
    end
  end
  DB:SetData(windowName .. "/Actor/Sub/", sub)
  DB:SetData(windowName .. "/Actor/Main/", main)
  DB:SetData(windowName .. "/Actor/All/", all)
end

function AU.GetActorLinkDesc(linkId, star, color, actionIndex, speIndex, withStarUp)
  local result = ""
  local linkEffect = SE.GetActorLinkEffect(linkId, star, actionIndex, speIndex)
  result = WU.FormatString(TU.render(WU.GetString("Window_ActorLinkDesc_" .. linkId), linkEffect), color or "")
  if withStarUp then
    result = result .. WU.FormatString(TU.render(WU.GetString("Window_ActorLinkStarUp_" .. linkId), linkEffect), color or "")
  end
  return result
end

function AU.GetActorTalentDesc(talent, normalColor, valueColor)
  local template = WU.GetString("SpecialAttrDescribe_" .. talent.talentId)
  if normalColor then
    template = HU.ApplyFontColor(template, normalColor)
  end
  return WU.FormatString(TU.render(template, SE.GetActorTalentEffect(talent)), valueColor or "")
end

function AU.GetSpecialEffectDesc(id, effect, color)
  return WU.FormatString(TU.render(WU.GetString("SpecialAttrDescribe_" .. id), effect), color or "")
end

function AU.GetTalentDisplayInfo(talentId, talentLevel)
  local talentName = WU.GetString("TalentName_" .. talentId)
  local resActorTalent = PB.get("ActorTalent", talentId)
  local talentIcon = 0
  if resActorTalent == nil then
    error("ActorUtil", "ActorTalent.xlsx error, Can't find by id " .. talentId)
  else
    talentIcon = resActorTalent.talentIcon
  end
  local data = {
    bgIdx = 1,
    isRatio = false,
    talentName = talentName,
    talentIcon = talentIcon,
    score = 0
  }
  local actorTalent = PB.get("ActorTalent", talentId)
  if actorTalent == nil then
    error("ActorUtil", "ActorTalent.xlsx error, Can't find talentId " .. talentId)
  else
    if actorTalent.ratioIcon then
      data.isRatio = true
    end
    data.score = AU.GetTalentScore(talentId, talentLevel)
    data.bgIdx = TalentMisc2Index(data.score)
  end
  return data
end

function AU.ActorTalentScore(actorInfo)
  local totalScore = 0
  if actorInfo ~= nil then
    local talentInfo = actorInfo.talentInfo
    for i = 1, #talentInfo do
      local resSpecialAttrInfo = PB.get("SpecialAttrInfo", talentInfo[i].talentId)
      if resSpecialAttrInfo then
        local score = resSpecialAttrInfo.score
        if 1 < resSpecialAttrInfo.maxLevel then
          score = resSpecialAttrInfo.score + (talentInfo[i].talentValue - 1) / (resSpecialAttrInfo.maxLevel - 1) * (resSpecialAttrInfo.scoreMax - resSpecialAttrInfo.score)
        end
        totalScore = totalScore + score
      else
        error("Talent", "key " .. talentInfo[i].talentId .. " was not found in SpecialAttrInfo.xlsx")
      end
    end
  end
  return math.floor(totalScore)
end

function AU.GetTalentScore(talentId, talentLevel)
  local score = 0
  local specialAttrInfo = PB.get("SpecialAttrInfo", talentId)
  if specialAttrInfo then
    score = specialAttrInfo.score
    if specialAttrInfo.maxLevel > 1 then
      score = specialAttrInfo.score + (talentLevel - 1) / (specialAttrInfo.maxLevel - 1) * (specialAttrInfo.scoreMax - specialAttrInfo.score)
    end
  else
    error("Talent", "key " .. talentId .. " was not found in SpecialAttrInfo.xlsx")
  end
  return math.ceil(score)
end

function TalentMisc2Index(val)
  local intervals = PB.all("TalentMisc")[1].interval
  for i = 1, #intervals do
    if val <= intervals[i].val then
      return i - 1
    end
  end
end

function AU.SetTalentBG(nodeRef, bgIdx, isRatio)
  nodeRef.TextureTalentBGA.UITexture.mainTexturePath = "Texture/ActorTalent/actor_talent_bg_" .. bgIdx
  if nodeRef.IsRatio ~= nil then
    nodeRef.IsRatio.gameObject:SetActive(isRatio)
  end
end

function AU.GetActorList(uids)
  local result = {}
  local uniqueIdList = _ENV["!"](uids):distinct():keys()
  for _, uid in pairs(uniqueIdList) do
    table.insert(result, DB:GetData("fci/actor/" .. uid))
  end
  return result
end

function AU.GetNextStarPhase(star, phase)
  phase = phase or 0
  local maxStar = PB.all("Misc"):first().maxStarLevel
  local resStarPhases = PB.index("Misc", 1).starPhases
  if star >= maxStar then
    return nil
  elseif phase < resStarPhases[star] then
    return star, phase + 1
  else
    return star + 1, 0
  end
end

function AU.UpgradeStarEnable(actor)
  if actor == nil then
    return false
  end
  local starFlag = false
  local isLevelOk = false
  local reachedMax = false
  local requiredLevel = 0
  local materialEnough = true
  local nextStar, nextPhase = AU.GetNextStarPhase(actor.star, actor.curPhase)
  local actorAttrStarPromotion = PB.get("ActorAttrStarPromotion", actor.id, nextStar, nextPhase)
  if actorAttrStarPromotion then
    local cost = actorAttrStarPromotion.starCost
    for i = 1, #cost do
      local starLevelupCost = cost[i]
      if starLevelupCost.type == PB.enum.ResourceType.ResItem then
        local cost = starLevelupCost.count
        local stock = DB:GetData("fci/item/" .. starLevelupCost.id).count
        if cost > stock then
          materialEnough = false
          break
        end
      end
    end
  else
    materialEnough = false
  end
  if actorAttrStarPromotion then
    isLevelOk = actorAttrStarPromotion.levelLimit <= actor.level
    requiredLevel = actorAttrStarPromotion.levelLimit
  else
    reachedMax = true
  end
  if not reachedMax and isLevelOk and materialEnough then
    starFlag = true
  end
  return starFlag
end

function AU.UpgradeLevelEnable(actor)
  local level = actor.level
  if level + 1 > DB:GetData("fci/baseinfo").level then
    return false
  end
  local totalExp = 0
  local expectExp = PB.get("ActorLevelup", level + 1).exp - actor.curExp
  local itmeList = PB.all("ItemInfo"):where(function(_, i)
    return i.funcType == PB.enum.ItemFuncType.ActorExp
  end)
  for k, v in pairs(itmeList) do
    local exp = DB:GetData("fci/item/" .. v.id).count * v.param[1]
    totalExp = totalExp + exp
  end
  return expectExp <= totalExp
end

function AU.GetAchievementInfo(achievementPoint, all)
  if all == nil then
    all = PB.all("AchievementPointTarget")
  end
  for i = 1, #all do
    if achievementPoint >= all[i].targetAchievementPoint and (all[i + 1] == nil or achievementPoint < all[i + 1].targetAchievementPoint) then
      local levelName = WU.GetString("AchievementTrophy_" .. all[i].trophy)
      if i ~= #all then
        levelName = levelName .. WU.GetString("AchievementLevel_" .. all[i].level)
      end
      return levelName, all[i].trophy
    end
  end
end

function AU.GetMaxAchievementPoint()
  local achievementInfo = PB.all("AchievementInfo")
  local maxPoint = 0
  for _, v in pairs(achievementInfo) do
    local rewards = v.reward
    local _, achievementPoint = table.find(rewards, function(key, value)
      return value.type == PB.enum.ResourceType.ResAchievementPoint
    end)
    if achievementPoint then
      maxPoint = maxPoint + achievementPoint.count
    end
  end
  return maxPoint
end

function AU.GetAllArmNum()
  local opened = _ENV["!"]({})
  local armInfo = PB.all("UniqueWeaponInfo")
  opened = _ENV["!"](armInfo):where(function(k, v)
    return U.IsTimeOpen(v.openTime)
  end)
  return opened:count()
end

function AU.GetAllSkinNum()
  local opened = _ENV["!"]({})
  local skinInfo = PB.all("ActorSkin")
  opened = _ENV["!"](skinInfo):where(function(K, v)
    local actors = v.actorIds
    local openTime = v.openTime
    local ignoreOpenTime = v.ignoreActorOpenTime
    if ignoreOpenTime then
      if U.IsTimeOpen(v.openTime) then
        return true
      end
    else
      for _, value in pairs(actors) do
        local actorInfo = PB.get("ActorConfig", value)
        if U.IsTimeOpen(v.openTime) and U.IsTimeOpen(actorInfo.openTime) then
          return true
        end
      end
    end
  end)
  return opened:count()
end

function AU.GetAllEquipNum()
  local equipInfo = PB.all("EquipInfo")
  local equips = _ENV["!"](equipInfo):where(function(key, value)
    return value.collectionsIndex ~= 0
  end)
  return equips:count()
end

function AU.GetAllEmojiNum()
  local emojiInfo = PB.all("ChatImage")
  local emojies = _ENV["!"](emojiInfo):where(function(k, v)
    return v.type == 1
  end)
  return emojies:count()
end

function AU.GetAllStoryCartoonNum()
  local cartoonInfo = PB.all("CartoonConfig")
  local mainStory = _ENV["!"]({})
  local count = 0
  for k, v in pairs(cartoonInfo) do
    if (v.storyType == PB.enum.CartoonStoryType.Main or v.storyType == PB.enum.CartoonStoryType.Fantasy or v.storyType == PB.enum.CartoonStoryType.Movie) and mainStory[v.dungeonId] == nil and v.dungeonId ~= 1004 and v.dungeonId ~= 1005 then
      mainStory[v.dungeonId] = true
      count = count + 1
    end
  end
  DB:SetData("cartoon", mainStory)
  return count
end

function AU.GetAllRolesNum()
  local collectionsRoles = DB:GetData("Collections/Actors") or {}
  return #collectionsRoles
end

function AU.GetAllMedalsNum()
  local medalInfo = PB.all("MedalInfo")
  return medalInfo:count()
end

function AU.ChangeTalentEffectTexture(refBg, refIcon, talentInfo)
  local textureBg = WU.AcquireAsset("Texture/ActorTalent/actor_talent_bg_" .. talentInfo.bgIdx)
  local textureTalent = WU.AcquireAsset("Texture/ActorTalent/ActorTalent_" .. talentInfo.talentIcon)
  if refBg ~= nil then
    refBg.MeshRenderer.material:SetTexture("_MainTex", textureBg)
    refIcon.MeshRenderer.material:SetTexture("_MainTex", textureTalent)
  end
end

function AU.ActorDeleteValidate(uid)
  if uid == 0 then
    return true
  end
  local groupActorUids = DB:GetData("GroupActorUids")
  if groupActorUids[uid] ~= nil and (groupActorUids[uid] & 16 ~= 0 or groupActorUids[uid] & 8 ~= 0) then
    return false
  end
  local actorCultivationInfo = DB:GetData("ActorCultivation")
  if actorCultivationInfo and 0 < #actorCultivationInfo then
    for _, v in pairs(actorCultivationInfo) do
      if v.actorId and uid == AU.GetHighestLevelActor(v.actorId) then
        return false
      end
    end
  end
  local customActorCultivationInfo = DB:GetData("fci/custom-actor-cultivation/")
  local culPlans = customActorCultivationInfo.culPlans
  if culPlans and 0 < #culPlans then
    for _, v in ipairs(culPlans) do
      if v.actorId and uid == AU.GetHighestLevelActor(v.actorId) then
        return false
      end
    end
  end
  local couple = DB:GetData("fci/couple/")
  if couple and couple.coupleActorId and couple.coupleActorId ~= 0 and uid == AU.GetHighestLevelActor(couple.coupleActorId) then
    return false
  end
  return true
end

function AU.AuraAttrAppend(actors, auraActorId, auraActorQuality)
  info("AuraAttrAppend")
  local actorQualityInfo = PB.get("ActorQualityInfo", auraActorId, auraActorQuality)
  if actorQualityInfo == nil then
    warning("AuraAttrAppend", "ActorQualityInfo.xlsx error, no actorId " .. tostring(auraActorId) .. " quality " .. tostring(auraActorQuality))
    return actors
  end
  local result = AttrAppend(actors, actorQualityInfo, "attrs")
  for i = 1, #result do
    if result[i].uid ~= nil then
      local copySpecialAttrIds = _ENV["!"]({})
      _ENV["!"](result[i].specialAttrIds):copy(copySpecialAttrIds)
      local pb = PB.get("SpecialAttrInfo", actorQualityInfo.specialAttrId)
      if not table.find(copySpecialAttrIds, function(_, v)
        return v == actorQualityInfo.specialAttrId
      end) and pb ~= nil then
        table.insert(copySpecialAttrIds, actorQualityInfo.specialAttrId)
        result[i].specialAttrIds = copySpecialAttrIds
      end
    end
  end
  return result
end

function AU.MazeActorAllDead()
  local actors = DB:GetData("MazeActors")
  if actors then
    local bAllDead = true
    for i, v in ipairs(actors) do
      local actorWrap = DB:GetData("fci/mazeactor/" .. v.uid)
      if actorWrap then
        local actorConfig = PB.get("ActorConfig", actorWrap.actor.id)
        if actorConfig then
          if actorConfig.kind == 1 and (actorWrap.dead == false or actorWrap.dead == nil or actorWrap.hp > 0) then
            bAllDead = false
            break
          end
        else
          error("actorConfig has no id " .. actorWrap.actor.id)
          return
        end
      end
    end
    return bAllDead
  end
  return false
end

function AU.MazeAuraAttrAppend(actors)
  local result = {}
  for i = 1, #actors do
    local copyActor = _ENV["!"]({})
    _ENV["!"](actors[i]):copy(copyActor, true)
    table.insert(result, copyActor)
  end
  local buffIdList = {}
  local buff = DB:GetData("MazeBuff")
  if buff then
    for k, v in pairs(buff) do
      local pb = PB.get("MazeBuff", v.buffId)
      if pb and pb.type == PB.enum.MazeBuffType.MazeBuff_Battle then
        buffIdList[#buffIdList + 1] = pb.param.value
      elseif pb and pb.type == PB.enum.MazeBuffType.MazeBuff_AttrChange then
        for i, v in ipairs(result) do
          if v.attrs and v.uid ~= nil then
            EffectAttrAppend(v.attrs, {
              type = pb.param.type,
              isRatio = pb.param.isRatio,
              value = pb.param.value
            })
          end
        end
      end
    end
  end
  for i = 1, #result do
    if result[i].uid ~= nil then
      local copySpecialAttrIds = _ENV["!"]({})
      _ENV["!"](result[i].specialAttrIds):copy(copySpecialAttrIds)
      for i, v in ipairs(buffIdList) do
        local pb = PB.get("SpecialAttrInfo", v)
        if pb ~= nil and not table.find(copySpecialAttrIds, function(_, v)
          return v == actorQualityInfo.specialAttrId
        end) then
          table.insert(copySpecialAttrIds, v)
        end
      end
      result[i].specialAttrIds = copySpecialAttrIds
    end
  end
  return result
end

function AU.MedalAttrAppend(actors, medalId)
  info("MedalAttrAppend")
  if medalId == nil or medalId == 0 then
    return actors
  end
  local medalInfo = PB.get("MedalInfo", medalId)
  if medalInfo == nil then
    warning("MedalAttrAppend", "MedalInfo.xlsx error, no id " .. tostring(medalId))
    return actors
  end
  local result = AttrAppend(actors, medalInfo, "equipAttrs")
  for i = 1, #result do
    if result[i].uid ~= nil then
      DebugAttr(result[i], actors[i], "equipAttrs")
    end
  end
  for i = 1, #result do
    local uid = result[i].uid
    if uid ~= nil then
      local changedActor = result[i]
      local originalActor = actors[i]
      for _, changedEquipAttr in pairs(changedActor.equipAttrs) do
        local _, originalAttr = table.find(originalActor.attrs, function(_, v)
          return v.type == changedEquipAttr.type
        end)
        local _, originalEquipAttr = table.find(originalActor.equipAttrs, function(_, v)
          return v.type == changedEquipAttr.type
        end)
        local find = table.find(changedActor.attrs, function(_, v)
          return v.type == changedEquipAttr.type
        end)
        if originalEquipAttr then
          changedActor.attrs[find].value = originalAttr.value - originalEquipAttr.value + changedEquipAttr.value
        else
          table.insert(changedActor.attrs, {
            type = changedEquipAttr.type,
            isRatio = changedEquipAttr.isRatio,
            value = changedEquipAttr.value
          })
        end
      end
      DebugAttr(result[i], originalActor, "attrs")
    end
  end
  return result
end

function DebugAttr(actor, originalActor, fieldName)
  info("DebugAttr", "fieldName :" .. fieldName)
  local changed = false
  for k, attr in pairs(actor[fieldName]) do
    local _, old = table.find(originalActor[fieldName], function(_, v)
      return v.type == attr.type
    end)
    if old then
      if old.value ~= attr.value then
        info("DebugAttr", "diff -> type " .. tostring(attr.type) .. " val -> from" .. tostring(old.value) .. " to " .. tostring(attr.value))
        changed = true
      end
    else
      info("DebugAttr", "new -> type" .. tostring(attr.type) .. " val -> " .. tostring(attr.value))
      changed = true
    end
  end
  if changed then
    info("DebugAttr", "actorId " .. tostring(actor.id))
  end
end

function AttrAppend(actors, xlsx, fieldName)
  local result = _ENV["!"]({})
  local effectAttrs = xlsx.effectAttrs
  local effectRoleIdAttr, effectActorIdAttr, effectBookIdAttr
  for i = 1, #actors do
    local copyActor = _ENV["!"]({})
    local attrs = _ENV["!"]({})
    effectRoleIdAttr = nil
    effectActorIdAttr = nil
    effectBookIdAttr = nil
    table.copy(actors[i], copyActor, true)
    if copyActor.id ~= nil then
      local actorConfig = PB.get("ActorConfig", copyActor.id)
      if xlsx.effectRoleIdAttr then
        local roleId = actorConfig.role
        local find = table.find(xlsx.effectRoleIdAttr.ids, function(_, v)
          return v == roleId
        end)
        if find then
          effectRoleIdAttr = xlsx.effectRoleIdAttr.attr
        end
      end
      if xlsx.effectActorIdAttr then
        local actorId = copyActor.id
        local find = table.find(xlsx.effectActorIdAttr.ids, function(_, v)
          return v == copyActor.id
        end)
        if find then
          effectActorIdAttr = xlsx.effectActorIdAttr.attr
        end
      end
      if xlsx.effectBookIdAttr then
        local bookId = actorConfig.book
        local find = table.find(xlsx.effectBookIdAttr.ids, function(_, v)
          return v == bookId
        end)
        if find then
          effectBookIdAttr = xlsx.effectBookIdAttr.attr
        end
      end
      for j = 1, #copyActor[fieldName] do
        local attr = copyActor[fieldName][j]
        local tmp = _ENV["!"]({})
        _ENV["!"](attr):copy(tmp)
        table.insert(attrs, tmp)
      end
      for j = 1, #effectAttrs do
        local attr = effectAttrs[j]
        EffectAttrAppend(attrs, attr)
      end
      EffectAttrAppend(attrs, effectRoleIdAttr)
      EffectAttrAppend(attrs, effectActorIdAttr)
      EffectAttrAppend(attrs, effectBookIdAttr)
      copyActor[fieldName] = attrs
    end
    table.insert(result, copyActor)
  end
  return result
end

function EffectAttrAppend(attrs, appendAttr)
  if appendAttr then
    local find = table.find(attrs, function(_, v)
      return v.type == appendAttr.type
    end)
    if find then
      attrs[find].value = attrs[find].value + appendAttr.value
    elseif not DoRateType(appendAttr, attrs) then
      table.insert(attrs, {
        type = appendAttr.type,
        isRatio = appendAttr.isRatio,
        value = appendAttr.value
      })
    end
  end
end

local RateType = {
  [PB.enum.AttrType.HpRate] = PB.enum.AttrType.Hp,
  [PB.enum.AttrType.AttackRate] = PB.enum.AttrType.Attack,
  [PB.enum.AttrType.PhysicalDefenseRate] = PB.enum.AttrType.PhysicalDefense,
  [PB.enum.AttrType.PenetrationRate] = PB.enum.AttrType.Penetration,
  [PB.enum.AttrType.MagicalDefenseRate] = PB.enum.AttrType.MagicalDefense
}

function DoRateType(appendAttr, attrs)
  local targetType = RateType[appendAttr.type]
  if targetType ~= nil then
    local _, find = table.find(attrs, function(_, v)
      return v.type == targetType
    end)
    if find == nil then
      return false
    end
    find.value = math.floor(find.value * (appendAttr.value / 10000 + 1))
    return true
  end
  return false
end

function AU.StarLevelupValidateActor(actor)
  if actor then
    local nextStar, nextPhase = AU.GetNextStarPhase(actor.star, actor.curPhase)
    return AU.StarLevelupValidate(actor, nextStar, nextPhase)
  end
end

function AU.StarLevelupValidate(actor, nextStar, nextPhase)
  local actorId = actor.id
  local level = actor.level
  local allowStarLevelup = false
  local maxStar = PB.all("Misc"):first().maxStarLevel
  local isMax = maxStar <= actor.star
  local requiredLevel = 0
  if not isMax then
    local actorAttrStarPromotion = PB.get("ActorAttrStarPromotion", actorId, nextStar, nextPhase)
    if actorAttrStarPromotion then
      allowStarLevelup = level >= actorAttrStarPromotion.levelLimit
      requiredLevel = actorAttrStarPromotion.levelLimit
    else
      error("ActorAttrStarPromotion", "cannot find ActorAttrStarPromotion id " .. tostring(actorId) .. " star " .. tostring(nextStar) .. " phase " .. tostring(nextPhase))
    end
  end
  return allowStarLevelup, isMax, requiredLevel
end

function AU.CalculateRoleScore(actorScoreData)
  local score = 0
  for i = 1, #actorScoreData do
    for j = 1, #actorScoreData[i].qualityInfo do
      score = score + actorScoreData[i].qualityInfo[j].quality
    end
  end
  return score
end

function AU.GetDecomposeResult(actor, cacheTable, hasResource)
  local result
  if cacheTable ~= nil then
    result = cacheTable[actor.uid]
  end
  if result == nil then
    local talentScore = AU.ActorTalentScore(actor)
    local coef = PB.all("Misc")[1].actorDecomposeTalentCoef
    local actorDecompose = PB.get("ActorDecompose", actor.id, actor.quality)
    result = {
      chips = {},
      resources = {}
    }
    if actorDecompose then
      for _, v in pairs(actorDecompose.decomposeRes) do
        if v.isChips then
          table.insert(result.chips, {
            type = v.type,
            id = v.id,
            count = math.floor(v.count + talentScore * coef)
          })
        else
          table.insert(result.resources, {
            type = v.type,
            id = v.id,
            count = v.count
          })
        end
      end
      if hasResource then
        local expSum = actor.curExp
        for i = 1, actor.level do
          local levelupinfo = PB.get("ActorLevelup", i)
          expSum = expSum + levelupinfo.exp
          if i == actor.level then
            expSum = expSum * (1 - levelupinfo.expLostRate / 10000)
          end
        end
        if expSum ~= 0 then
          local expItems = AU.DecomposeToExpItems(expSum, PB.enum.ItemFuncType.ActorExp)
          for _, v in pairs(expItems) do
            table.insert(result.resources, {
              type = PB.enum.ResourceType.ResItem,
              id = v.id,
              count = v.cnt
            })
          end
        end
      end
    else
      error("ActorDecompose", "can't find data in ActorDecompose with id: " .. tostring(actor.id))
    end
    if cacheTable then
      cacheTable[actor.uid] = result
    end
  end
  return result
end

function AU.IsActorOpen(actorId, openTime)
  local isOpen = false
  if openTime == nil or openTime == "" then
    isOpen = true
  else
    local actorOpenTime = CS.GameTime.ServerTimeStrToUtc(openTime)
    local now = CS.GameTime.serverUtc
    if actorOpenTime <= now then
      isOpen = true
    end
  end
  return isOpen
end

function AU.DecomposeToExpItems(expSum, expType)
  local possessTable, possessCnt = GenMaxPossessTable(expType)
  local expItems, isReached, isOverflow = GreedyFoodEating(expSum, possessTable, possessCnt, {})
  expItems = ReconstructFoodsTable(expItems)
  if isOverflow then
    local t = expItems[#expItems]
    t.cnt = t.cnt - 1
    if t.cnt == 0 then
      table.remove(expItems)
    end
  end
  return expItems
end

function AU.CheckActorStarRandom(id, param)
  local actorQuality = 0
  local actorStar = 0
  local actor = PB.get("ActorStarRandom", id, param)
  if actor then
    for _, v in pairs(actor.starRandoms) do
      if 0 < v.rate then
        if 0 < actorStar then
          if actorStar > v.star then
            actorStar = v.star
          end
        else
          actorStar = v.star
        end
      end
    end
    for _, v in pairs(actor.talentCountRandoms) do
      if 0 < v.rate then
        if 0 < actorQuality then
          if actorQuality > v.count then
            actorQuality = v.count
          end
        else
          actorQuality = v.count
        end
      end
    end
  end
  if actorQuality < 1 then
    actorQuality = 1
  end
  if actorStar < 1 then
    actorStar = 1
  end
  return actorQuality, actorStar
end

function GenMaxPossessTable(expType)
  local items = AU.GetItems(expType, function(a, b)
    return a.itemInfo.param[1] > b.itemInfo.param[1]
  end, true)
  local possessTable = {}
  local possessCnt = {}
  for i = 1, #items do
    local itemInfo = items[i].itemInfo
    table.insert(possessTable, {
      exp = itemInfo.param[1],
      id = itemInfo.id
    })
    table.insert(possessCnt, 99999)
  end
  return possessTable, possessCnt
end

function GreedyFoodEating(expSum, possessTable, possessCnt, foodTable)
  if expSum == 0 then
    return foodTable, true, false
  elseif expSum < 0 then
    local lastFood = foodTable[#foodTable]
    local lastFoodIdx = table.find(possessTable, function(_, val)
      return lastFood.id == val.id
    end)
    local nextFoodIdx = lastFoodIdx + 1
    if possessTable and possessTable[nextFoodIdx] then
      expSum = expSum + lastFood.exp
      table.remove(foodTable)
      possessCnt[lastFoodIdx] = possessCnt[lastFoodIdx] + 1
      expSum = expSum - possessTable[nextFoodIdx].exp
      table.insert(foodTable, possessTable[nextFoodIdx])
      possessCnt[nextFoodIdx] = possessCnt[nextFoodIdx] - 1
      return GreedyFoodEating(expSum, possessTable, possessCnt, foodTable)
    end
    return foodTable, true, true
  elseif possessTable and 0 < #possessTable then
    if #foodTable == 0 then
      expSum = expSum - possessTable[1].exp
      table.insert(foodTable, possessTable[1])
      possessCnt[1] = possessCnt[1] - 1
      return GreedyFoodEating(expSum, possessTable, possessCnt, foodTable)
    else
      local lastFood = foodTable[#foodTable]
      local lastFoodIdx = table.find(possessTable, function(_, val)
        return lastFood.id == val.id
      end)
      local nextFoodIdx = lastFoodIdx + 1
      if possessCnt[lastFoodIdx] ~= 0 then
        expSum = expSum - possessTable[lastFoodIdx].exp
        table.insert(foodTable, possessTable[lastFoodIdx])
        possessCnt[lastFoodIdx] = possessCnt[lastFoodIdx] - 1
      elseif possessTable[nextFoodIdx] then
        expSum = expSum - possessTable[nextFoodIdx].exp
        table.insert(foodTable, possessTable[nextFoodIdx])
        possessCnt[nextFoodIdx] = possessCnt[nextFoodIdx] - 1
      else
        return foodTable, false, false
      end
      return GreedyFoodEating(expSum, possessTable, possessCnt, foodTable)
    end
  else
    return {}, false, false
  end
end

function ReconstructFoodsTable(foods)
  local i = 1
  local cnt = 1
  local result = {}
  if foods then
    while i <= #foods do
      if foods[i + 1] and foods[i + 1].id == foods[i].id then
        cnt = cnt + 1
      else
        local param = {
          id = foods[i].id,
          cnt = cnt,
          exp = foods[i].exp
        }
        table.insert(result, param)
        cnt = 1
      end
      i = i + 1
    end
  end
  return result
end

function AU.GetActorCultivationDegree(actor, ratio)
  return math.floor(AU.GetActorCultivationDegreeAttr(actor, ratio) + AU.GetActorCultivationDegreeSkill(actor, ratio) + AU.GetActorCultivationDegreeTalent(actor, ratio) + AU.GetActorCultivationDegreeSuit(actor) + AU.GetActorCultivationDegreeArm(actor, ratio))
end

function AU.GetActorCultivationDegreeAttr(actor, ratio)
  if actor then
    if ratio then
      if not table.empty(actor.weaponAttrs) then
        local attrs = {}
        table.copy(actor.attrs, attrs, true)
        local actorAttrTypeToIndex = {}
        for i = 1, #attrs do
          actorAttrTypeToIndex[attrs[i].type] = i
        end
        for i = 1, #actor.weaponAttrs do
          local armAttr = actor.weaponAttrs[i]
          local actorAttr = attrs[actorAttrTypeToIndex[armAttr.type]]
          if actorAttr then
            actorAttr.value = actorAttr.value - armAttr.value
          end
        end
        return AU.GetCultivationDegreeAttr(attrs, ratio)
      else
        return AU.GetCultivationDegreeAttr(actor.attrs, ratio)
      end
    else
      return AU.GetCultivationDegreeAttr(actor.attrs, ratio)
    end
  else
    return 0
  end
end

function AU.GetCultivationDegreeAttr(attrs, ratio)
  local degree = 0
  local cultivationDegree = PB.index("CultivationDegree", 1)
  local attrMap = AU.NormalizeAttrs(attrs)
  if ratio == nil then
    degree = cultivationDegree.paramHp * attrMap[PB.enum.AttrType.Hp].value + cultivationDegree.paramAtk * attrMap[PB.enum.AttrType.Attack].value + cultivationDegree.paramDefPhysical * attrMap[PB.enum.AttrType.PhysicalDefense].value + cultivationDegree.paramDefMagic * attrMap[PB.enum.AttrType.MagicalDefense].value + cultivationDegree.paramCritRate * attrMap[PB.enum.AttrType.CriticalHitRate].value + cultivationDegree.paramCritDmg * attrMap[PB.enum.AttrType.CriticalHitDamageRate].value
  else
    degree = cultivationDegree.paramHp * math.floor(attrMap[PB.enum.AttrType.Hp].value * ratio) + cultivationDegree.paramAtk * math.floor(attrMap[PB.enum.AttrType.Attack].value * ratio) + cultivationDegree.paramDefPhysical * math.floor(attrMap[PB.enum.AttrType.PhysicalDefense].value * ratio) + cultivationDegree.paramDefMagic * math.floor(attrMap[PB.enum.AttrType.MagicalDefense].value * ratio) + cultivationDegree.paramCritRate * math.floor(attrMap[PB.enum.AttrType.CriticalHitRate].value * ratio) + cultivationDegree.paramCritDmg * math.floor(attrMap[PB.enum.AttrType.CriticalHitDamageRate].value * ratio)
  end
  return degree
end

function AU.GetActorCultivationDegreeSkill(actor, ratio)
  local degree = 0
  ratio = ratio or 1
  if actor then
    local cultivationDegree = PB.index("CultivationDegree", 1)
    local activeSkills = SE.GetActorSkills(actor.id, true)
    local actorConfig = PB.get("ActorConfig", actor.id)
    if actorConfig.kind == PB.enum.ActorType.Main then
      if activeSkills[1] and activeSkills[1][1] then
        degree = degree + math.max(1, math.floor(SE.GetSkillLevel(actor, activeSkills[1][1].skillId) * ratio)) * cultivationDegree.paramSkillOne
      else
        warning("GetActorCultivationDegreeSkill", " actorId " .. tostring(actor.id) .. " , activeSkills[1][1] is nil? \232\191\153\228\184\170\232\167\146\232\137\178\228\184\139\229\143\145\231\154\132\230\138\128\232\131\189\230\156\137\233\151\174\233\162\152\239\188\129")
      end
      if activeSkills[2] and activeSkills[2][1] then
        degree = degree + math.max(1, math.floor(SE.GetSkillLevel(actor, activeSkills[2][1].skillId) * ratio)) * cultivationDegree.paramSkillTwo
      else
        warning("GetActorCultivationDegreeSkill", " actorId " .. tostring(actor.id) .. " , activeSkills[2][1] is nil? \232\191\153\228\184\170\232\167\146\232\137\178\228\184\139\229\143\145\231\154\132\230\138\128\232\131\189\230\156\137\233\151\174\233\162\152\239\188\129")
      end
      if activeSkills[3] and activeSkills[3][1] then
        degree = degree + math.max(1, math.floor(SE.GetSkillLevel(actor, activeSkills[3][1].skillId) * ratio)) * cultivationDegree.paramSkillThree
      else
        warning("GetActorCultivationDegreeSkill", " actorId " .. tostring(actor.id) .. " , activeSkills[3][1] is nil? \232\191\153\228\184\170\232\167\146\232\137\178\228\184\139\229\143\145\231\154\132\230\138\128\232\131\189\230\156\137\233\151\174\233\162\152\239\188\129")
      end
    elseif actorConfig.kind == PB.enum.ActorType.Sub then
      if activeSkills[1] and activeSkills[1][1] then
        degree = degree + math.max(1, math.floor(SE.GetSkillLevel(actor, activeSkills[1][1].skillId) * ratio)) * cultivationDegree.paramSkillSub
      else
        warning("GetActorCultivationDegreeSkill", " actorId " .. tostring(actor.id) .. " , activeSkills[1][1] is nil? \232\191\153\228\184\170\232\167\146\232\137\178\228\184\139\229\143\145\231\154\132\230\138\128\232\131\189\230\156\137\233\151\174\233\162\152\239\188\129")
      end
    end
  end
  return degree
end

function AU.GetActorCultivationDegreeTalent(actor, ratio)
  local degree = 0
  ratio = ratio or 1
  if actor then
    local cultivationDegree = PB.index("CultivationDegree", 1)
    for _, talentInfo in pairs(actor.talentInfo) do
      local actorTalent = PB.get("ActorTalent", talentInfo.talentId)
      if actorTalent.spectial == 1 then
        local talentScore = AU.GetTalentScore(talentInfo.talentId, math.max(math.floor(talentInfo.talentValue * ratio), 1))
        degree = degree + talentScore * cultivationDegree.paramTalentExclusive
      end
    end
  end
  return degree
end

function AU.GetActorCultivationDegreeSuit(actor)
  local degree = 0
  if actor then
    local cultivationDegree = PB.index("CultivationDegree", 1)
    local suits = EU.GetSuits(actor)
    local equips = EU.GetEquips(actor)
    for _, suit in pairs(suits) do
      local suitInfo = EA.GetSuitInfo(suit.equipId[1], equips)
      for _, attr in pairs(suitInfo.attrList) do
        if attr.activated then
          degree = degree + attr.suitCul
        end
      end
    end
  end
  return degree
end

function AU.GetActorCultivationDegreeArm(actor, ratio)
  if ratio then
    return 0
  end
  local arm = AU.GetArmByActor(actor)
  return AU.GetCultivationDegreeArm(arm, ratio)
end

function AU.GetCultivationDegreeArm(arm, ratio)
  local degree = 0
  if arm then
    local config = PB.get("UniqueWeaponAscend", arm.quality, arm.phase + 1)
    if config == nil then
      error("GamePlay", string.format("UniqueWeaponAscend\232\161\168\230\178\161\230\156\137\233\133\141\229\174\140\239\188\140quality: %s, phase: %s", arm.quality, arm.phase + 1))
      return 0
    else
      degree = degree + config.cultivation
    end
    local speAttr = arm.speAttr[1]
    local config = PB.get("UniqueWeaponAttrEnhanceInfo", speAttr.attrId, speAttr.level)
    if config == nil then
      error("GamePlay", string.format("UniqueWeaponAttrEnhanceInfo\232\161\168\230\178\161\230\156\137\233\133\141\229\174\140\239\188\140id: %s, level: %s", arm.id, arm.level + 1))
      return 0
    else
      degree = degree + config.cultivation
    end
  end
  return degree
end

function AU.TryResetTalent(actor, pos, resetImpl)
  local talentResetCost = PB.get("TalentResetCost", actor.id)
  WU.TryToPay(talentResetCost.cost.type, talentResetCost.cost.id, talentResetCost.cost.count, function()
    resetImpl()
  end, function()
    if DB:GetData("UseGenericChipForTalentReset") then
      local costStock = 0
      if talentResetCost.cost.type == PB.enum.ResourceType.ResItem then
        costStock = DB:GetData("fci/item/" .. talentResetCost.cost.id).count
      else
        costStock = DB:GetData("fci/resource/" .. PB.enum.ResourceType.__keys[talentResetCost.cost.type] .. "_" .. talentResetCost.cost.id)
      end
      local subCostCount = talentResetCost.costSub.count - math.max(0, costStock)
      WU.TryToPay(talentResetCost.costSub.type, talentResetCost.costSub.id, subCostCount, function()
        if costStock <= 0 then
          resetImpl()
        else
          local extraCostString = "<img src='ResIcon_s." .. PB.enum.ResourceType.__keys[talentResetCost.costSub.type] .. "_" .. talentResetCost.costSub.id .. "'/>&nbsp;" .. subCostCount
          WU.ShowMessageYesNo(WU.GetString("Talent_PaySubCost", extraCostString), function(result)
            if result == "YES" then
              resetImpl()
            end
          end)
        end
      end, function()
        WU.ShowHintText(WU.GetString("Talent_ResetCostNotEnough"))
      end)
    else
      WU.ShowHintText(WU.GetString("Talent_ResetCostNotEnough"))
    end
  end)
end

function AU.NormalizeAttrs(attrs)
  local attrTable = _ENV["!"]({})
  for _, attr in pairs(attrs) do
    attrTable[attr.type] = attr
  end
  for _, type in pairs(PB.enum.AttrType) do
    local isRatio = string.find(PB.enum.AttrType.__keys[type], "Rate") ~= nil
    if not attrTable[type] then
      attrTable[type] = {
        type = type,
        value = 0,
        isRatio = isRatio
      }
    end
  end
  return attrTable
end

function AU.GetActorPaletteIndex(actorId, skinId)
  if skinId == 0 then
    return 0
  end
  local resSkin = PB.get("ActorSkin", skinId)
  if resSkin then
    local paletteIndexs = resSkin.paletteIndexs
    local index = table.find(resSkin.actorIds, function(k, v)
      return v == actorId
    end)
    if index then
      local paletteIndex = paletteIndexs[index]
      if paletteIndex then
        return paletteIndex
      else
        error("ActorSkin.xlsx", string.format("can't find paletteIndex, skinId: %s, actorId: %s", skinId, actorId))
      end
    else
      error("ActorSkin.xlsx", string.format("can't find actorId, skinId: %s, actorId: %s", skinId, actorId))
    end
  else
    error("ActorSkin.xlsx", "can't find row, skinId: " .. skinId)
  end
end

function AU.SetActorSkinPreview(gasketTex, gasketTexKuroyukihime, actorId, skinId)
  local resConfig = PB.get("ActorConfig", actorId)
  if resConfig then
    gasketTex.UITexture.mainTexturePath = "Texture/ActorSkinHeadBig/ActorSkinHead_big_" .. resConfig.skinUIRes
    gasketTex.UITexture.maskTexturePath = string.format("Dependencies/Sprite2D/Role/%s/%s_palette", resConfig.prefabRes, resConfig.prefabRes)
    WU.ToggleRendering(gasketTexKuroyukihime, actorId == 1014 or actorId == 1514 or actorId == 2014)
    local paletteIndex = AU.GetActorPaletteIndex(actorId, skinId)
    if paletteIndex then
      gasketTex.UITexture.additionalParam = paletteIndex
    end
  else
    error("ActorSkin", string.format("Cannot find Actor by actorId: %s, skinId: %s", tostring(actorId), tostring(skinId)))
  end
end

function AU.GetActorEquipTotalScore(actor)
  local result = 0
  for _, uid in pairs(actor.bodyEquips) do
    local equip = DB:GetData("fci/equip/" .. uid)
    result = result + math.floor(equip.score)
  end
  return result
end

function AU.GetSkinActors(skinId)
  local actorIds = {}
  local resSkin = PB.get("ActorSkin", skinId)
  if resSkin then
    for i = 1, #resSkin.actorIds do
      local resConfig = PB.get("ActorConfig", resSkin.actorIds[i])
      if resConfig and (resSkin.ignoreActorOpenTime or AU.IsActorOpen(resConfig.id, resConfig.openTime)) then
        table.insert(actorIds, resConfig.id)
      end
    end
  end
  return actorIds
end

function AU.IsActorSkinOpen(skinId)
  local isOpen = false
  local skinConfig = PB.get("ActorSkin", skinId)
  if skinConfig then
    local openTime = skinConfig.openTime
    if openTime == nil or openTime == "" then
      isOpen = true
    else
      local skinOpenTime = CS.GameTime.ServerTimeStrToUtc(openTime)
      local now = CS.GameTime.serverUtc
      if skinOpenTime <= now then
        isOpen = true
      end
    end
  else
    error("ActorSkin", "Cannot find skin in ActorSkin.xlsx, id: " .. skinId)
  end
  return isOpen
end

function AU.GetActorNovel(actorId)
  local _, resNovel = PB.all("Novel"):find(function(_, v)
    return table.has(v.actors, actorId)
  end)
  if resNovel then
    return resNovel.id
  else
    warning("Novel", "cannot find which novel the actor belongs to, actor id: " .. tostring(actorId))
  end
end

function AU.GetRoleNovel(roleId)
  local _, resConfig = PB.all("ActorConfig"):find(function(k, v)
    return AU.IsActorOpen(v.id, v.openTime) and v.role == roleId
  end)
  if resConfig then
    local actorId = resConfig.id
    return AU.GetActorNovel(actorId)
  else
    warning("Novel", "cannot find which novel the role belongs to, role id: " .. tostring(roleId))
  end
end

function AU.GetImprovePart(actor)
  local tableName
  local actorInfo = DB:GetData("fci/actor/" .. actor.uid)
  local levelUpInfo = PB.get("ActorLevelup", actor.level)
  local suitPast
  if levelUpInfo.equipCulRatio == nil then
    suitPast = true
  else
    local equipSuit = AU.GetActorCultivationDegreeSuit(actor) + AU.GetCultivationDegreeAttr(actor.equipAttrs)
    local acCul = AU.GetActorCultivationDegree(actor) - equipSuit
    suitPast = equipSuit >= acCul * levelUpInfo.equipCulRatio * 1.0E-4
  end
  if not suitPast then
    return "TabEquip"
  end
  if AU.UpgradeStarEnable(actorInfo) then
    return "TabStar"
  end
  if SE.HasSkillToUpgrade(actorInfo) then
    return "TabSkill"
  end
  if AU.UpgradeLevelEnable(actorInfo) then
    return "TabCultivation"
  end
  if not WU.WindowIsLocked(PB.enum.UnlockWindow.TalentReset) then
    local talentResetCost = PB.get("TalentResetCost", actorInfo.id)
    local costCount = DB:GetData("fci/item/" .. tostring(talentResetCost.cost.id)).count
    if 0 < costCount then
      return "TabTalent"
    end
    local costSubCount = DB:GetData("fci/item/" .. tostring(talentResetCost.costSub.id)).count
    if 0 < costSubCount then
      return "TabTalent"
    end
  end
  return "TabEquip"
end

function AU.RenderAuraOrMedalAttr(xlsxInfo, singleline, windowName, color, noColor, noPostFix)
  local text = ""
  if xlsxInfo == nil then
    return text
  end
  local attrReturn
  local lineBreak = fif(singleline, " ", "<br/>")
  if xlsxInfo.effectAttrs and #xlsxInfo.effectAttrs > 0 then
    for i = 1, #xlsxInfo.effectAttrs do
      local attr = xlsxInfo.effectAttrs[i]
      if attr.type and 0 < attr.type then
        attrReturn = attr.type
        local stringColor
        if windowName == "MySpace" then
          stringColor = "#00f6ff"
        elseif color then
          stringColor = color
        else
          stringColor = "#0199E9"
        end
        text = text .. WU.GetString("Window_ActorAttrName_" .. attr.type)
        if noColor then
          text = text .. "+" .. U.FormatAttrValue(attr)
        else
          text = text .. HU.ApplyFontColor("+" .. U.FormatAttrValue(attr), stringColor)
        end
        if not noPostFix then
          text = text .. WU.GetString("Window_ForAllActors") .. ";" .. lineBreak
        end
      end
    end
  end
  if xlsxInfo.effectRoleIdAttr ~= nil and xlsxInfo.effectRoleIdAttr.attr ~= nil and 0 < xlsxInfo.effectRoleIdAttr.attr.type then
    text = text .. HU.RenderOtherAttr(xlsxInfo.effectRoleIdAttr, "Window_bracket1", "RoleName_", WU.GetString("Window_Valid")) .. ";" .. lineBreak
  end
  if xlsxInfo.effectActorIdAttr ~= nil and xlsxInfo.effectActorIdAttr.attr ~= nil and 0 < xlsxInfo.effectActorIdAttr.attr.type then
    text = text .. HU.RenderOtherAttr(xlsxInfo.effectActorIdAttr, "Window_bracket3", "ActorName_", WU.GetString("Window_Valid")) .. ";" .. lineBreak
  end
  if xlsxInfo.effectBookIdAttr ~= nil and xlsxInfo.effectBookIdAttr.attr ~= nil and 0 < xlsxInfo.effectBookIdAttr.attr.type then
    text = text .. HU.RenderOtherAttr(xlsxInfo.effectBookIdAttr, "Window_bracket2", "NovelName_", WU.GetString("Window_RoleValid")) .. ";" .. lineBreak
  end
  if xlsxInfo.specialAttrId and 0 < xlsxInfo.specialAttrId then
    text = text .. AU.GetSpecialEffectDesc(xlsxInfo.specialAttrId, SE.GetSpecialEffect(xlsxInfo.specialAttrId)) .. ";" .. lineBreak
  end
  return string.gsub(text, "</br>$", ""), attrReturn
end

function AU.CheckActorOverflow()
  local actors = DB:GetData("fci/actor/")
  if #actors >= PB.index("Misc", 1).maxActorWarningCount then
    WU.ShowMessageYesNo(WU.GetString("ActorOverflowWarning"), function(result)
      if result == "YES" then
        WU.AcquireWindowAsync("ActorDecompose")
      end
    end, WU.GetString("Window_Decompose"))
    return true
  end
  return false
end

function AU.ModifyActorAttrByRatio(actor, ratio)
  local actor = _ENV["!"](actor):duplicate()
  actor.attrs[PB.enum.AttrType.Hp] = actor.attrs[PB.enum.AttrType.Hp] * ratio
  actor.attrs[PB.enum.AttrType.Attack] = actor.attrs[PB.enum.AttrType.Attack] * ratio
  actor.attrs[PB.enum.AttrType.PhysicalDefenseRate] = actor.attrs[PB.enum.AttrType.PhysicalDefenseRate] * ratio
  actor.attrs[PB.enum.AttrType.MagicalDefense] = actor.attrs[PB.enum.AttrType.MagicalDefense] * ratio
  actor.attrs[PB.enum.AttrType.CriticalHitRate] = actor.attrs[PB.enum.AttrType.CriticalHitRate] * ratio
  actor.attrs[PB.enum.AttrType.CriticalHitDamageRate] = actor.attrs[PB.enum.AttrType.CriticalHitDamageRate] * ratio
  return actor
end

function AU.GetActorListById(actorId)
  local actorList = _ENV["!"](DB:GetData("fci/actor/")):duplicate()
  local resList = _ENV["!"]({})
  for _, actor in pairs(actorList) do
    if actor.id == actorId then
      table.insert(resList, actor)
    end
  end
  if resList:empty() then
    warning("ActorCultivationActorSelect", "UnExpected Fatal error: no actor with id:" .. actorId)
    return
  end
  table.sort(resList, function(a, b)
    if a.level == b.level then
      return a.quality < b.quality
    else
      return a.level < b.level
    end
  end)
  return resList
end

function AU.RenameDungeonNPCFields(actor)
  if actor == nil then
    return
  end
  actor.id = actor.actorId
  actor.talentInfo = actor.talents
  actor.equipAttrs = {}
  actor.bodyEquips = {}
  actor.speed = U.GetAttrValue(actor.attrs, PB.enum.AttrType.Speed)
  actor.cultivationTotal = AU.GetActorCultivationDegree(actor)
end

function AU.GetHighestLevelActor(actorId, noErr)
  local actorList = _ENV["!"](DB:GetData("fci/actor/")):duplicate()
  local resList = _ENV["!"]({})
  for _, actor in pairs(actorList) do
    if actor.id == actorId then
      table.insert(resList, actor)
    end
  end
  if resList:empty() then
    if noErr then
      return
    end
    error("ActorCultivationActorSelect", "UnExpected Fatal error: no actor with id:" .. actorId)
    return
  end
  table.sort(resList, function(a, b)
    if a.level == b.level then
      if a.curExp == b.curExp then
        return a.quality > b.quality
      else
        return a.curExp > b.curExp
      end
    else
      return a.level > b.level
    end
  end)
  return resList[1].uid
end

function AU.HasActorWithID(id)
  if id == nil then
    return
  end
  local actorIDSet = DB:GetData("ActorIDSet")
  if actorIDSet == nil then
    actorIDSet = _ENV["!"]({})
    local actorList = DB:GetData("fci/actor/")
    for _, actor in pairs(actorList) do
      actorIDSet[actor.id] = actor
    end
    DB:SetData("ActorIDSet", actorIDSet)
  end
  return actorIDSet[id]
end

function AU.GetArmByActor(actor)
  if not actor.uniqueWeaponId and actor.uniqueWeaponId ~= 0 then
    return nil
  end
  return DB:GetData("fci/arms/" .. actor.uniqueWeaponId)
end

function AU.GetActorByArm(arm)
  local ac = DB:GetData("fci/actor/" .. arm.actorUid)
  return ac
end

function AU.CalcExpDiff(oldLevel, oldExp, newLevel, newExp)
  if oldLevel == newLevel then
    return newExp - oldExp
  end
  local p1 = PB.get("ActorLevelup", oldLevel + 1).exp - oldExp
  local p2 = 0
  for i = oldLevel + 2, newLevel do
    p2 = p2 + PB.get("ActorLevelup", i).exp
  end
  return p1 + p2 + newExp
end

function AU.IsAsyncPvpNewUpActor(actor)
  local baseInfo = DB:GetData("AsyncPvpNew/BaseInfo")
  if baseInfo == nil then
    return false
  end
  local upActors = PB.get("AsyncPvpUpActor", baseInfo.upActorWeekIndex + 1)
  if upActors == nil then
    warning("AsyncPvpUpActor.xlsx doesnt have info of weekNum " .. baseInfo.upActorWeekIndex + 1)
    return false
  end
  local actors = upActors.specialActors
  local _, v = table.find(actors, function(k1, v1)
    return v1 == actor.id
  end)
  return v ~= nil
end

function AU.OnGetMazeActorPool(res)
  if res == nil then
    return
  end
  local actors = {}
  for i, v in pairs(res.selectActors) do
    if v.actor then
      if v.hp == 0 and v.dead == false then
        local attrs = v.actor.attrs
        for k, v2 in pairs(attrs) do
          if v2.type == PB.enum.AttrType.Hp then
            v.hp = v2.value
            break
          end
        end
      elseif v.dead == true then
        v.hp = 0
      end
      v.actor.alive = fif(v.dead, 0, 1)
      actors[#actors + 1] = v.actor
      DB:SetData("fci/mazeactor/" .. v.actor.uid, v)
    end
  end
  DB:SetData("fci/mazeactor/", actors)
  DB:SetData("MazeActors", actors)
end

return AU
