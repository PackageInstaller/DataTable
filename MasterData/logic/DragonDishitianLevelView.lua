-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragondishitian/view/DragonDishitianLevelView.lua

module("logic.extensions.dragondishitian.view.DragonDishitianLevelView", package.seeall)

local DragonDishitianLevelView = class("DragonDishitianLevelView", ViewComponent)

function DragonDishitianLevelView:ctor()
	DragonDishitianLevelView.super.ctor(self)
end

function DragonDishitianLevelView:buildUI()
	DragonDishitianLevelView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._levelList = {}

	local pathPrefix = "levels/level"

	for i = 1, 3 do
		local go = self:getGo(pathPrefix .. i)
		local prize = self:getGo("levels/prize" .. i)
		local element = {}

		element.btn = go
		element.lock = goutil.findChild(go, "lock")
		element.normal = goutil.findChild(go, "normal")
		element.pass = goutil.findChild(go, "pass")
		element.txtDesc = goutil.findChildTextComponent(prize, "txt")
		element.node = goutil.findChild(prize, "node")

		table.insert(self._levelList, element)
	end
end

function DragonDishitianLevelView:bindEvents()
	DragonDishitianLevelView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)

	for i, v in ipairs(self._levelList) do
		GameUtil.addClickHandler(v.btn, GameUtil.handler(self._onClickLevel, self, i))
	end
end

function DragonDishitianLevelView:unbindEvents()
	DragonDishitianLevelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)

	for i, v in ipairs(self._levelList) do
		GameUtil.rmClickHandler(v.btn)
	end
end

function DragonDishitianLevelView:onEnter()
	DragonDishitianLevelView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DragonDishitianGetInfoRes, self._onGetInfoRes, self)

	self._activityId = self:getFirstParam()

	self:_initLevels()
end

function DragonDishitianLevelView:onExit()
	DragonDishitianLevelView.super.onExit(self)

	for i, v in ipairs(self._levelList) do
		MaterialMgr.resetAll(v.node)
	end
end

function DragonDishitianLevelView:_onClickLevel(chapterId)
	local cfg = DragonDishitianConfig.instance:getChapterCfg(self._activityId, chapterId)
	local isMatchOpenTime = DragonDishitianModel.instance:isMatchOpenTime(self._activityId, chapterId)
	local isPassPreChapter = DragonDishitianModel.instance:isPassPreChapter(self._activityId, chapterId)

	if not isMatchOpenTime then
		local date = GameUtil.string2date(cfg.openTime)

		FloatWordMgr.instance:show(string.format("%02d.%02d 05:00 开启", date.month, date.day))

		return
	end

	if not isPassPreChapter then
		FloatWordMgr.instance:show("请先通过前置关卡")

		return
	end

	self:_openClgView(chapterId)
end

function DragonDishitianLevelView:_openClgView(chapterId)
	UIStateManager.instance:push(ViewName.DragonDishitianClgView, self._activityId, chapterId)
end

function DragonDishitianLevelView:_onGetInfoRes()
	self:_updateLevels()
end

function DragonDishitianLevelView:_initLevels()
	for chapterId, v in ipairs(self._levelList) do
		local cfg = DragonDishitianConfig.instance:getChapterCfg(self._activityId, chapterId)
		local matType, id, matNum = MaterialMgr.getMatParams(cfg.prize)
		local name = MaterialMgr.getMaterialsName(matType, id)

		v.txtDesc.text = string.format("挑战获得\n%s", name)

		MaterialMgr.setCellByCfg(cfg.prize, v.node)
	end

	self:_updateLevels()
end

function DragonDishitianLevelView:_updateLevels()
	for chapterId, v in ipairs(self._levelList) do
		local cfg = DragonDishitianConfig.instance:getChapterCfg(self._activityId, chapterId)
		local isPass = DragonDishitianModel.instance:isPassChapter(self._activityId, chapterId)
		local isMatchOpenTime = DragonDishitianModel.instance:isMatchOpenTime(self._activityId, chapterId)
		local isPassPreChapter = DragonDishitianModel.instance:isPassPreChapter(self._activityId, chapterId)
		local isUnlock = isMatchOpenTime and isPassPreChapter

		GameUtil.SetActive(v.pass, isPass)
		GameUtil.SetActive(v.lock, not isUnlock)
		GameUtil.SetActive(v.normal, not isPass and isUnlock)
	end
end

return DragonDishitianLevelView
