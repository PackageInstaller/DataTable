local MergeSubView = {}
local this = MergeSubView

local nextStar
local canMerge = false

local levelText 
local nextLevelText
local levelArrow
local starRoot
local nextStarRoot
local starArrow
local starMax

local desc
local nextDesc
local effectArrow
local nextEffectRoot

local maxStatus
---@type FightSoul[]
local matterItemList
--- 战魂Object模板
local rawItem
--- 所有素材的gameObject
local materialItems

local StarText
local NextStarText

local mergeButton

local SkipButton
local SkipTick

---@type FightSoul[] @素材列表(数据层)
local materials

--- 星级限制
local FIGHT_SOUL_MERGE_COUNT_LIMIT = tonumber(Z_Misc["FIGHT_SOUL_MERGE_COUNT_LIMIT"].Value[1])
--- 战魂等级限制
local FIGHT_SOUL_LEVEL_LIMIT_BY_MERGE = Z_Misc["FIGHT_SOUL_LEVEL_LIMIT_BY_MERGE"].Value
-- 初始化
---@param self UIFightSoulInfoView
function this.Init(self, gameObject)

    ---@type ReferenceCollector
    local rc = gameObject:GetComponent("ReferenceCollector")
    LangUtil.GetSpriteLang(478, function(sprite) rc:GetObject("PropertyTitle"):GetComponent("Image").sprite = sprite end)
    LangUtil.GetSpriteLang(472, function(sprite) rc:GetObject("EquipEffectTitle"):GetComponent("Image").sprite = sprite end)
    LangUtil.GetSpriteLang(467, function(sprite) rc:GetObject("CostTextImage"):GetComponent("Image").sprite = sprite end)
    LangUtil.BindText(rc:GetObject("MaxText")).text = LangUtil.GetSysLang(1451)
    levelText = LangUtil.BindText(rc:GetObject("LevelText"))
    nextLevelText = LangUtil.BindText(rc:GetObject("NextLevelText"))
    levelArrow = rc:GetObject("LevelArrow")

    starRoot = rc:GetObject("StarRoot").transform
    nextStarRoot = rc:GetObject("NextStarRoot").transform
    starArrow = rc:GetObject("StarArrow")
    starMax = rc:GetObject("StarMax")

    desc = LangUtil.BindText(rc:GetObject("Desc"))
    nextDesc = LangUtil.BindText(rc:GetObject("NextDesc"))
    effectArrow = rc:GetObject("EffectArrow")
    nextEffectRoot = rc:GetObject("NextEffectRoot")

    maxStatus = rc:GetObject("MaxStatus")
    matterItemList = rc:GetObject("MatterList")
    rawItem = rc:GetObject("Item")
    materialItems = {
        [1] = rawItem
    }

    SkipButton = rc:GetObject("SkipButton")
    SkipTick = rc:GetObject("SkipTick")

    StarText = LangUtil.BindText(rc:GetObject("StarText"))
    NextStarText = LangUtil.BindText(rc:GetObject("NextStarText"))

    mergeButton = rc:GetObject("MergeButton")

    UIUtil.AddBtnEvent(SkipButton, function()
        self.isSkip = not self.isSkip
        if self.isSkip then
            self.clientData.isSkipFightSoulMerge = 1
            PlayerPrefs.SetInt("IsSkipFightSoulMerge", 1)
        else
            self.clientData.isSkipFightSoulMerge = 0
            PlayerPrefs.SetInt("IsSkipFightSoulMerge", 0)
        end
        SkipTick.gameObject:SetActive(self.isSkip)
    end)

    UIUtil.AddBtnEvent(matterItemList, function()
        if not canMerge then
            return
        end
        if self.model.fightSoul.Star >= FIGHT_SOUL_MERGE_COUNT_LIMIT then
            return
        end
        local chooseIds = {}
        for index, value in ipairs(materials) do
            table.insert(chooseIds, value.Id)
        end
        UIManager:GetInstance():OpenWindow(UIWindowNames.UIFightSoulMergeMaterials, {
            id = self.model.fightSoul.Id,
            cid = self.model.fightSoul.TemplateId,
            chooseIds = chooseIds,
            callBack = function(ids)
                materials = {}
                for _, id in ipairs(ids) do
                    table.insert(materials, Game.Scene.Player:GetComponent("FightSoulComponent"):Get(id))
                end
                this.RefreshInfo(self)
            end
        })
    end)

    UIUtil.AddBtnEvent(mergeButton, function()
        if table.count(materials) == 0 then
            Logger.LogError(LangUtil.GetSysLang(1072))
            return
        end
        local ids = {}
        for key, value in pairs(materials) do
            table.insert(ids, value.Id)
        end
        local uid =  self.model.fightSoul.Id
        local oldStar = self.model.fightSoul.Star
        PublicRequest.SendRequest(
            PROTOCOL.FightSoulMergeReq,
            {
                uid = uid,
                materials = ids,
            },
            function(response)
                if not self.isSkip then
                    coroutine.start(function()
                        coroutine.waitforframes(1)
                        ---@type FightSoul
                        local fightSoul = Game.Scene.Player:GetComponent("FightSoulComponent"):Get(uid)
                        UIManager:GetInstance():OpenWindow(UIWindowNames.UIFightSoulFuse,{
                            fightSoul = fightSoul,
                            Star = fightSoul.Star,
                            oldStar = oldStar,
                        })
                    end)
                end
            end
        )
    end)

    LangUtil.BindText(rc:GetObject("levelInfoText")).text = LangUtil.GetSysLang(1244)
    LangUtil.BindText(rc:GetObject("StarInfotext")).text = LangUtil.GetSysLang(1245)
    materials = {}
end

---@param self UIFightSoulInfoView
function this.OnLangCreate(self)
end

---@param self UIFightSoulInfoView
function this.OnEnable(self)
    materials = {}
end

---@param self UIFightSoulInfoView
function this.OnRefresh(self)
    levelText.text = self.model.fightSoul.maxLevel
    StarText.text = "Lv<size=36>" .. self.model.fightSoul.Star .. "</size>"
    if self.model.fightSoul.Star >= FIGHT_SOUL_MERGE_COUNT_LIMIT then
        --- 星级上限
        levelArrow:SetActive(false)
        nextLevelText.text = ""
        starRoot.gameObject:SetActive(false)
        starArrow:SetActive(false)
        nextStarRoot.gameObject:SetActive(false)
        starMax:SetActive(true)
        maxStatus:SetActive(true)
        effectArrow:SetActive(false)
        nextEffectRoot:SetActive(false)
        canMerge = false
    else
        levelArrow:SetActive(true)
        starRoot.gameObject:SetActive(true)
        starArrow:SetActive(true)
        nextStarRoot.gameObject:SetActive(true)
        starMax:SetActive(false)
        maxStatus:SetActive(false)
        effectArrow:SetActive(true)
        nextEffectRoot:SetActive(true)
        nextStar = self.model.fightSoul.Star
        canMerge = true
    end
    SkipTick.gameObject:SetActive(self.isSkip)
    UIPublic.InitButton(mergeButton, self.model.fightSoul.Star < FIGHT_SOUL_MERGE_COUNT_LIMIT)
    this.RefreshInfo(self)
end

---@param self UIFightSoulInfoView
function this.RefreshInfo(self)
    if materials == nil or table.count(materials) == 0 then
        for key, value in pairs(materialItems) do
            value:SetActive(false)
        end
        rawItem:SetActive(canMerge)
        rawItem.transform:GetChild(0).gameObject:SetActive(false)
    else
        rawItem.transform:GetChild(0).gameObject:SetActive(true)
        for index, fightSoul in ipairs(materials) do
            local item = materialItems[index]
            if item == nil then
                item = GameObject.Instantiate(rawItem)
                item.transform:SetParent(matterItemList.transform, false)
                item:SetActive(true)

                item.transform:SetParent(rawItem.transform.parent)
                item.transform.localPosition = Vector3.New(0,0,0)
                item.transform.localScale = Vector3.New(1,1,1)
                materialItems[index] = item
            end
            item:SetActive(true)
            UIPublic.InitVsFightSoulItemMId(fightSoul,item.transform:GetChild(0).gameObject)
        end
        for i = table.count(materials) + 1, table.count(materialItems) do
            materialItems[i]:SetActive(false)
        end
    end

    local star = self.model.fightSoul.Star
    levelText.text = FIGHT_SOUL_LEVEL_LIMIT_BY_MERGE[star]
    for i = 0, starRoot.childCount-1 do
        local child = starRoot:GetChild(i)
        if i < star then
            child.gameObject:SetActive(true)
        else
            child.gameObject:SetActive(false)
        end
    end

    desc.text = UIPublic.GetFightSoulEffectText(self.model.fightSoul.TemplateId, star)

    if canMerge then
        if materials ~= nil and table.count(materials) > 0 then
            nextStar = self.model.fightSoul.Star
            for _, value in pairs(materials) do
                nextStar = nextStar + value.Star
            end
            if nextStar > FIGHT_SOUL_MERGE_COUNT_LIMIT then
                nextStar = FIGHT_SOUL_MERGE_COUNT_LIMIT
            end
        else
            nextStar = self.model.fightSoul.Star + 1
        end

        for i = 0, nextStarRoot.childCount-1 do
            local child = nextStarRoot:GetChild(i)
            if i < nextStar then
                child.gameObject:SetActive(true)
            else
                child.gameObject:SetActive(false)
            end
        end
    
        nextDesc.text = UIPublic.GetFightSoulEffectText(self.model.fightSoul.TemplateId, nextStar)
        NextStarText.text = "Lv<size=36>" .. nextStar .. "</size>"
        nextLevelText.text = FIGHT_SOUL_LEVEL_LIMIT_BY_MERGE[nextStar]
    end


end

---@param self UIFightSoulInfoView
function this.OnDisable(self)
end

---@param self UIFightSoulInfoView
function this.OnDestroy(self)
end

---@param self UIFightSoulInfoView
function this.ClearChoose(self)
    materials = {}
end

---@param self UIFightSoulInfoView
function this.OnFightSoulUpdate(self)
    table.removeall(materials, function(v)
        return Game.Scene.Player:GetComponent("FightSoulComponent"):Get(v.Id) == nil
    end)
end

return this