-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragondishitian/view/DragonDishitianClgView.lua

module("logic.extensions.dragondishitian.view.DragonDishitianClgView", package.seeall)

local DragonDishitianClgView = class("DragonDishitianClgView", ViewComponent)

function DragonDishitianClgView:ctor()
	DragonDishitianClgView.super.ctor(self)
end

function DragonDishitianClgView:buildUI()
	DragonDishitianClgView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnChallenge = self:getBtn("btnChallenge")
	self._txtTitle = self:getTxt("txtTitle")
	self.scrollerGo = self:getGo("tableview")
	self.cellGo = self:getGo("tablecell")
	self._scrollList = ScrollerList.create(self.scrollerGo, self.cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
	self.scrollerGo2 = self:getGo("tableview2")
	self.cellGo2 = self:getGo("tablecell2")
	self._scrollList2 = ScrollerList.create(self.scrollerGo2, self.cellGo2, GameUtil.handler(self._updateCell2, self), GameUtil.handler(self.clearCell2, self))

	self._scrollList2:extendCircleWithOffset(40, "btn")

	self._iconList = {}

	for i = 1, 3 do
		self._iconList[i] = self:getGo("icons/icon" .. i)
	end

	self:_buildStarmap()
end

function DragonDishitianClgView:_buildStarmap()
	local starMapGo = self:getResInstance(DragonDishitianController.StarMapPath)
	local childStarMapGo = self:getResInstance(DragonDishitianController.ChildStarMapPath)
	local mapParent = self:getGo("area/map")
	local childMapParent = self:getGo("tablecell/map")

	goutil.addChildToParent(starMapGo, mapParent)
	goutil.addChildToParent(childStarMapGo, childMapParent)

	starMapGo.name = string.gsub(starMapGo.name, "%(Clone%)", "")
	starMapGo.transform.localPosition = Vector3.zero
	childStarMapGo.name = string.gsub(childStarMapGo.name, "%(Clone%)", "")
	childStarMapGo.transform.localPosition = Vector3.zero

	GameUtil.setAnchoredPos(childStarMapGo, 0, 0)

	self._starMapGo = starMapGo
	self._clsStarMap = GameUtil.AddLuaOnce(self._starMapGo, StarMapItem)
end

function DragonDishitianClgView:bindEvents()
	DragonDishitianClgView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
end

function DragonDishitianClgView:unbindEvents()
	DragonDishitianClgView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnChallenge)
end

function DragonDishitianClgView:onEnter()
	DragonDishitianClgView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._chapterId = params[2]

	self:_initView()
end

function DragonDishitianClgView:onExit()
	DragonDishitianClgView.super.onExit(self)

	if self._clsStarMap then
		self._clsStarMap:reset()
	end
end

function DragonDishitianClgView:_onClickChallenge()
	local isPass = DragonDishitianModel.instance:isPassStage(self._activityId, self._chapterId, self._selectStageId)

	if isPass then
		FloatWordMgr.instance:show("已通关")
	else
		DragonDishitianController.instance:openMissionView(self._activityId, self._chapterId, self._selectStageId)
	end
end

function DragonDishitianClgView:_updateCell(view, cell, data, tag)
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local passGo = goutil.findChild(cell, "pass")
	local unpassGo = goutil.findChild(cell, "unPass")
	local starIcon = goutil.findChild(cell, "starIcon")
	local childStarMap = goutil.findChild(cell, "map/childstarmap")
	local cls = GameUtil.AddLuaOnce(childStarMap, ChildStarMapItem)
	local conditionId = data

	cls:init(self._activityId, self._chapterId, self._selectStageId, conditionId)

	local cfg = DragonDishitianConfig.instance:getPassConditionCfg(conditionId)

	txtDesc.text = cfg.desc

	local isPass = DragonDishitianModel.instance:isPassCondition(self._activityId, self._chapterId, self._selectStageId, conditionId)

	GameUtil.SetActive(passGo, isPass)
	GameUtil.SetActive(unpassGo, not isPass)

	local cfgStage = DragonDishitianConfig.instance:getStageCfg(self._activityId, self._chapterId, self._selectStageId)
	local index = table.keyof(cfgStage.conditionIds, conditionId)

	uGuiUtil.setSpriteToImage(starIcon, uGuiUtil.SpriteType.BigBg, string.format("ui/bigbg/views/challenges/dragondishitian/%s.png", cfgStage.res[index]))
end

function DragonDishitianClgView:clearCell(cell)
	local starIcon = goutil.findChild(cell, "starIcon")
	local starMap = goutil.findChild(cell, "btn/map/starmap")

	uGuiUtil.clearImage(starIcon)

	local cls = GameUtil.AddLuaOnce(starMap, ChildStarMapItem)

	cls:reset()
end

function DragonDishitianClgView:_updateCell2(view, cell, data, tag)
	local txtName = goutil.findChildTextComponent(cell, "btn/txtName")
	local passGo = goutil.findChild(cell, "btn/pass")
	local selectGo = goutil.findChild(cell, "btn/select")
	local btn = goutil.findChild(cell, "btn")
	local stageId = data.stageId
	local isPass = DragonDishitianModel.instance:isPassStage(self._activityId, self._chapterId, stageId)

	txtName.text = "关卡" .. stageId

	GameUtil.SetActive(passGo, isPass)
	GameUtil.SetActive(selectGo, self._selectStageId == stageId)
	GameUtil.addClickHandler(btn, function()
		self:_updateView(stageId)
	end)
end

function DragonDishitianClgView:clearCell2(cell)
	return
end

function DragonDishitianClgView:_initView()
	local cfg = DragonDishitianConfig.instance:getChapterCfg(self._activityId, self._chapterId)

	self._txtTitle.text = cfg.name

	for i, v in ipairs(self._iconList) do
		GameUtil.SetActive(v, i == self._chapterId)
	end

	self._selectStageId = 1

	local cfgs = DragonDishitianConfig.instance:getStageCfgList(self._activityId, self._chapterId)

	for i, cfg in ipairs(cfgs) do
		local isPass = DragonDishitianModel.instance:isPassStage(self._activityId, self._chapterId, cfg.stageId)

		if not isPass then
			self._selectStageId = cfg.stageId

			break
		end
	end

	self:_updateView(self._selectStageId)
end

function DragonDishitianClgView:_updateView(stageId)
	self._selectStageId = stageId

	self:_updateStages()
	self:_updateStageInfo(self._selectStageId)
	self:_updateCondtions(self._selectStageId)
end

function DragonDishitianClgView:_updateStageInfo(stageId)
	self._clsStarMap:init(self._activityId, self._chapterId, self)
	self._clsStarMap:refreshStarState()
end

function DragonDishitianClgView:_updateCondtions(stageId)
	local cfg = DragonDishitianConfig.instance:getStageCfg(self._activityId, self._chapterId, stageId)

	self._scrollList:reloadData(cfg.conditionIds)
end

function DragonDishitianClgView:_updateStages()
	local cfgs = DragonDishitianConfig.instance:getStageCfgList(self._activityId, self._chapterId)

	self._scrollList2:reloadData(cfgs)
end

return DragonDishitianClgView
