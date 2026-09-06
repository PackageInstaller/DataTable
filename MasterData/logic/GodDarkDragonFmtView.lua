-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddarkdragon/view/GodDarkDragonFmtView.lua

module("logic.extensions.goddarkdragon.view.GodDarkDragonFmtView", package.seeall)

local GodDarkDragonFmtView = class("GodDarkDragonFmtView", ViewComponent)

function GodDarkDragonFmtView:ctor()
	GodDarkDragonFmtView.super.ctor(self)
end

function GodDarkDragonFmtView:unbindEvents()
	GodDarkDragonFmtView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnHide)
	GameUtil.rmClickHandler(self._btnShow)
	GameUtil.rmClickHandler(self._btnSure)
end

function GodDarkDragonFmtView:bindEvents()
	GodDarkDragonFmtView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnHide, self._onClickHide, self)
	GameUtil.addClickHandler(self._btnShow, self._onClickShow, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function GodDarkDragonFmtView:buildUI()
	GodDarkDragonFmtView.super.buildUI(self)

	local go = self:getGo("info/emenyFmt")

	self._enemyList = {}

	for i = 1, 9 do
		self._enemyList[i] = {
			go = goutil.findChild(go, "teamEnemy/cell_" .. i),
			con = goutil.findChild(go, "teamEnemy/cell_" .. i .. "/icon"),
			select = goutil.findChild(go, "teamEnemy/cell_" .. i .. "/select")
		}
	end

	self._btnHide = self:getGo("info/btnHide")
	self._showGo = self:getGo("showGo")
	self._btnShow = self:getGo("showGo/btnShow")
	self._btnSure = self:getGo("info/btnSure")
	self._txtNum = self:getTxt("info/txtNum")
	self._txtRule = self:getTxt("info/txtRule")
	self._infoGo = self:getGo("info")
end

function GodDarkDragonFmtView:onExit()
	GodDarkDragonFmtView.super.onExit(self)
end

function GodDarkDragonFmtView:onEnter()
	GodDarkDragonFmtView.super.onEnter(self)

	self._fmtMo = self:getFirstParam()

	local stageCfg = GodDarkDragonConfig.instance:getMainStageCfg(self._fmtMo.activityId, self._fmtMo.stageId)

	self._cfgEnemy = GodDarkDragonConfig.instance:getTeamCfg(stageCfg.creepsMasterId)
	self._masterList = GodDarkDragonConfig.instance:getCreepsCfg(stageCfg.creepsMasterId)
	self._selectList = {}
	self._selectCount = 0

	self:refreshView()
	self:_onClickShow()
end

function GodDarkDragonFmtView:refreshView()
	for i = 1, 9 do
		MaterialMgr.resetAll(self._enemyList[i].con)
		GameUtil.SetActive(self._enemyList[i].go, false)
	end

	for i, v in ipairs(self._masterList) do
		GameUtil.setLocalScale(self._enemyList[v.posId].con, 0.8, 0.8, 0.8)

		local proxy = MaterialMgr.setCell(MatType.Pet, v.raceId, self._enemyList[v.posId].con)

		GameUtil.SetActive(self._enemyList[v.posId].go, true)
		GameUtil.SetActive(self._enemyList[v.posId].select, self._selectList[i])
		proxy.binder:setClickCallBack(function()
			self:onClickPet(i)
		end)
	end

	self._txtNum.text = langPara("已选：%d/%d", self._selectCount, math.max(#self._masterList - self._fmtMo.enemyLimit, 0))
	self._txtRule.text = langPara("星宇祝福：敌方上阵精灵数<color=#20B376FF>%d</color>只", self._fmtMo.enemyLimit)
end

function GodDarkDragonFmtView:onClickPet(index)
	if checknumber(self._cfgEnemy.forbidPetIndex) > 0 and checknumber(self._cfgEnemy.forbidPetIndex) == index then
		FloatWordMgr.instance:show(lang("英雄技所属精灵不可下阵"))

		return
	end

	if self._selectList[index] then
		self._selectList[index] = false
		self._selectCount = self._selectCount - 1
	elseif self._fmtMo.enemyLimit >= #self._masterList - self._selectCount then
		FloatWordMgr.instance:show(lang("已达可选上限"))
	else
		self._selectList[index] = true
		self._selectCount = self._selectCount + 1
	end

	self:refreshView()
end

function GodDarkDragonFmtView:_onClickHide()
	GameUtil.SetActive(self._infoGo, false)
	GameUtil.SetActive(self._showGo, true)
end

function GodDarkDragonFmtView:_onClickShow()
	GameUtil.SetActive(self._infoGo, true)
	GameUtil.SetActive(self._showGo, false)
end

function GodDarkDragonFmtView:_onClickSure()
	local list = self._masterList
	local resultList = {}

	for i, v in ipairs(list) do
		if not self._selectList[i] then
			table.insert(resultList, v)
		end
	end

	if self._selectCount > 0 then
		self:_onClickHide()
	end

	self._fmtMo:setMasterList(resultList)
	GlobalDispatcher:dispatch(GlobalNotify.RefreshEnemyFmt)
end

return GodDarkDragonFmtView
