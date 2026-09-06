-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragondishitian/view/StarMapItem.lua

module("logic.extensions.dragondishitian.view.StarMapItem", package.seeall)

local StarMapItem = class("StarMapItem")
local ColorLevel1 = "#CCE0EFFF"
local ColorLevel2 = "#F9E2BEFF"
local ColorLevel3 = "#D8CEEAFF"
local ShineColorLevel1 = "#CCE0EFFF"
local ShineColorLevel2 = "#FFD800FF"
local ShineColorLevel3 = "#D100FFFF"
local effectPath1 = "20240313/fx_ui_tiaozhan_lan.prefab"
local effectPath2 = "20240313/fx_ui_tiaozhan_huang.prefab"
local effectPath3 = "20240313/fx_ui_tiaozhan_zi.prefab"

function StarMapItem:ctor(luaComponentContainer)
	local go = luaComponentContainer.gameObject

	self._lines = goutil.findChild(go, "lines")
	self._stars = goutil.findChild(go, "stars")
	self._starRecordPos = self._stars:GetComponent("TestRecordPos")
	self._starGo = goutil.findChild(go, "baseGos/starGo")
	self._lineGo = goutil.findChild(go, "baseGos/lineGo")

	goutil.setActive(self._starGo, false)
	goutil.setActive(self._lineGo, false)

	self._starList = {}
	self._lineList = {}
	self._normalLines = goutil.findChildComponent(go, "normalLines", ComponentType.LineGraphic)
	self._shineLines = goutil.findChildComponent(go, "shineLines", ComponentType.LineGraphic)
	self._uiEffectDic = {}
end

function StarMapItem:init(activityId, chapterId, view)
	self._activityId = activityId
	self._chapterId = chapterId
	self._view = view

	local cfgChapter = DragonDishitianConfig.instance:getChapterCfg(activityId, chapterId)
	local starMapId = cfgChapter.starMapId

	self._starNum = cfgChapter.starNum
	self._lineNum = self._starNum - 1

	self:_refreshStars(cfgChapter.starNum)
	self._starRecordPos:LoadPlan(starMapId)
	self:_updateActiveState(cfgChapter.starNum)
	self:_updateNormalLines()
end

function StarMapItem:_getNormalColor()
	return Framework.ColorUtil.ParseColor(self._chapterId == 1 and ColorLevel1 or self._chapterId == 2 and ColorLevel2 or ColorLevel3)
end

function StarMapItem:_getShineColor()
	return Framework.ColorUtil.ParseColor(self._chapterId == 1 and ShineColorLevel1 or self._chapterId == 2 and ShineColorLevel2 or ShineColorLevel3)
end

function StarMapItem:refreshStarState()
	local starActivesList = {}

	for starId = 1, self._starNum do
		local stageId, conditionId = DragonDishitianController.instance:getConditionIdbyStarId(self._activityId, self._chapterId, starId)
		local isPass = DragonDishitianModel.instance:isPassCondition(self._activityId, self._chapterId, stageId, conditionId)

		GameUtil.SetActive(self._starList[starId].effectGo, isPass)

		if isPass then
			self:_loadEffect(self._starList[starId].effectGo)
		end

		starActivesList[starId] = isPass
	end

	local color = self:_getShineColor()
	local lineWidth = 6

	self._shineLines:ClearVertices()

	for i, v in ipairs(self._starList) do
		if self._starList[i + 1] then
			if starActivesList[i] then
				if starActivesList[i] then
					local startPos = GameUtil.getAnchoredPos(v.go)
					local endPos = GameUtil.getAnchoredPos(self._starList[i + 1].go)

					self._shineLines:AddVertices(startPos, endPos, color, lineWidth)
				end
			end
		end
	end
end

function StarMapItem:reset()
	self._normalLines:ClearVertices()
	self._shineLines:ClearVertices()
	self:_clearEffects()
end

function StarMapItem:_refreshStars(starNum)
	if starNum > #self._starList then
		local addNum = starNum - #self._starList
		local count = #self._starList

		for i = 1, addNum do
			local cell = {}
			local index = count + i

			cell.go = goutil.cloneAndSetParent(self._starGo, self._stars.transform, "star_" .. index)
			cell.effectGo = goutil.findChild(cell.go, "effect")

			GameUtil.SetActive(cell.effectGo, false)
			self:_removeEffect(cell.effectGo)

			self._starList[index] = cell
		end
	end
end

function StarMapItem:_updateActiveState(starNum)
	for i, v in ipairs(self._starList) do
		goutil.setActive(v.go, i <= starNum)
	end
end

function StarMapItem:_updateNormalLines()
	self._normalLines:ClearVertices()

	local vecList = {}

	for i, v in ipairs(self._starList) do
		if i <= self._starNum then
			table.insert(vecList, GameUtil.getAnchoredPos(v.go))
		end
	end

	local color = self:_getNormalColor()
	local lineWidth = 2

	for i, v in ipairs(vecList) do
		if vecList[i + 1] then
			self._normalLines:AddVertices(vecList[i], vecList[i + 1], color, lineWidth)
		end
	end
end

function StarMapItem:_getEffectPath()
	if self._chapterId == 1 then
		return effectPath1
	elseif self._chapterId == 2 then
		return effectPath2
	else
		return effectPath3
	end
end

function StarMapItem:_loadEffect(go)
	self:_removeEffect(go)

	local path = self:_getEffectPath()
	local uiEffect = UIEffectManager.instance:playEffect(self._view, path, go.transform, 0, 0, true, false)

	uiEffect:setParent(go.transform)
	uiEffect:setScale(1)
	uiEffect:setLocalPos(0, 0, 0)

	self._uiEffectDic[go:GetInstanceID()] = uiEffect
end

function StarMapItem:_removeEffect(go)
	local uiEffect = self._uiEffectDic[go:GetInstanceID()]

	if uiEffect then
		self._uiEffectDic[go:GetInstanceID()] = nil

		UIEffectManager.instance:stopEffect(uiEffect)
	end
end

function StarMapItem:_clearEffects()
	for k, v in pairs(self._uiEffectDic) do
		UIEffectManager.instance:stopEffect(v)
	end

	table.clear(self._uiEffectDic)
end

return StarMapItem
