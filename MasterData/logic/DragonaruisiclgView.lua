-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonaruisi/view/DragonaruisiclgView.lua

module("logic.extensions.dragonaruisi.view.DragonaruisiclgView", package.seeall)

local DragonaruisiclgView = class("DragonaruisiclgView", DragonDishitianClgView)
local ColorLevel1 = "#CCE0EFFF"
local ColorLevel2 = "#F9E2BEFF"
local ShineColorLevel1 = "#CCE0EFFF"
local ShineColorLevel2 = "#FFD800FF"
local effectPath1 = "20240313/fx_ui_tiaozhan_lan.prefab"
local effectPath2 = "20240313/fx_ui_tiaozhan_huang.prefab"

function DragonaruisiclgView:onExit()
	DragonaruisiclgView.super.onExit(self)
	self:reset()
end

function DragonaruisiclgView:_buildStarmap()
	self._starmap = self:getGo("area/map/starmap")
	self._lines = goutil.findChild(self._starmap, "lines")
	self._stars = goutil.findChild(self._starmap, "stars")
	self._starRecordPos = self._stars:GetComponent("TestRecordPos")
	self._starGo = goutil.findChild(self._starmap, "baseGos/starGo")
	self._lineGo = goutil.findChild(self._starmap, "baseGos/lineGo")

	goutil.setActive(self._starGo, false)
	goutil.setActive(self._lineGo, false)

	self._starList = {}
	self._lineList = {}
	self._normalLines = goutil.findChildComponent(self._starmap, "normalLines", ComponentType.LineGraphic)
	self._shineLines = goutil.findChildComponent(self._starmap, "shineLines", ComponentType.LineGraphic)
	self._uiEffectDic = {}
end

function DragonaruisiclgView:_updateCell(view, cell, data, tag)
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local passGo = goutil.findChild(cell, "pass")
	local unpassGo = goutil.findChild(cell, "unPass")
	local conditionId = data
	local cfg = DragonDishitianConfig.instance:getPassConditionCfg(conditionId)

	txtDesc.text = cfg.desc

	local cfgStage = DragonDishitianConfig.instance:getStageCfg(self._activityId, self._chapterId, self._selectStageId) or {}
	local index = table.keyof(cfgStage.conditionIds, conditionId)

	if not cfgStage.starIds then
		if not cfgStage.starIds[index] then
			local starArr = {}

			txtDesc.text = langPara("<color=#21E7EFFF>%s</color>\n激活星图节点：\n<color=#F6FF62FF>%s</color>", cfg.desc, table.concat(starArr, ", "))

			local isPass = DragonDishitianModel.instance:isPassCondition(self._activityId, self._chapterId, self._selectStageId, conditionId)

			GameUtil.SetActive(passGo, isPass)
			GameUtil.SetActive(unpassGo, not isPass)
		end
	end
end

function DragonaruisiclgView:clearCell(cell)
	return
end

function DragonaruisiclgView:_updateStageInfo(stageId)
	local cfgChapter = DragonDishitianConfig.instance:getChapterCfg(self._activityId, self._chapterId)
	local starMapId = cfgChapter.starMapId

	self._starNum = cfgChapter.starNum
	self._lineNum = self._starNum - 1

	self:_refreshStars(cfgChapter.starNum)
	self._starRecordPos:LoadPlan(starMapId)
	self:_updateActiveState(cfgChapter.starNum)
	self:_updateNormalLines()
	self:refreshStarState()
end

function DragonaruisiclgView:_getNormalColor()
	return Framework.ColorUtil.ParseColor(self._chapterId == 1 and ColorLevel1 or self._chapterId == 2 and ColorLevel1 or ColorLevel2)
end

function DragonaruisiclgView:_getShineColor()
	return Framework.ColorUtil.ParseColor(self._chapterId == 1 and ShineColorLevel1 or self._chapterId == 2 and ShineColorLevel1 or ShineColorLevel2)
end

function DragonaruisiclgView:refreshStarState()
	local starActivesList = {}

	for starId = 1, self._starNum do
		local stageId, conditionId = DragonDishitianController.instance:getConditionIdbyStarId(self._activityId, self._chapterId, starId)
		local isPass = DragonDishitianModel.instance:isPassCondition(self._activityId, self._chapterId, stageId, conditionId)

		GameUtil.SetActive(self._starList[starId].imgNumGo, not isPass)
		GameUtil.SetActive(self._starList[starId].starImg, isPass)
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

function DragonaruisiclgView:reset()
	self._normalLines:ClearVertices()
	self._shineLines:ClearVertices()
	self:_clearEffects()
end

function DragonaruisiclgView:_refreshStars(starNum)
	if starNum > #self._starList then
		local addNum = starNum - #self._starList
		local count = #self._starList

		for i = 1, addNum do
			local cell = {}
			local index = count + i

			cell.go = goutil.cloneAndSetParent(self._starGo, self._stars.transform, "star_" .. index)
			cell.starImg = goutil.findChild(cell.go, "starImg")
			cell.effectGo = goutil.findChild(cell.go, "effect")
			cell.imgNumGo = goutil.findChild(cell.go, "imgNum")
			cell.imgNum = cell.imgNumGo:GetComponent(ComponentType.UIImgNumeralText)

			cell.imgNum:SetNum(index)
			GameUtil.SetActive(cell.starImg, false)
			GameUtil.SetActive(cell.effectGo, false)
			self:_removeEffect(cell.effectGo)

			self._starList[index] = cell
		end
	end
end

function DragonaruisiclgView:_updateActiveState(starNum)
	for i, v in ipairs(self._starList) do
		goutil.setActive(v.go, i <= starNum)
	end
end

function DragonaruisiclgView:_updateNormalLines()
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

function DragonaruisiclgView:_getEffectPath()
	if self._chapterId == 1 then
		return effectPath1
	elseif self._chapterId == 2 then
		return effectPath1
	else
		return effectPath2
	end
end

function DragonaruisiclgView:_loadEffect(go)
	self:_removeEffect(go)

	local path = self:_getEffectPath()

	self:playViewEffectUniGo(path, go)
end

function DragonaruisiclgView:_removeEffect(go)
	self:stopViewEffectUniGo(go)
end

function DragonaruisiclgView:_clearEffects()
	return
end

return DragonaruisiclgView
