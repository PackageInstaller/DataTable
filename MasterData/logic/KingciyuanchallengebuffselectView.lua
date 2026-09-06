-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingciyuanchallenge/view/KingciyuanchallengebuffselectView.lua

module("logic.extensions.kingciyuanchallenge.view.KingciyuanchallengebuffselectView", package.seeall)

local KingciyuanchallengebuffselectView = class("KingciyuanchallengebuffselectView", ViewComponent)

function KingciyuanchallengebuffselectView:ctor()
	KingciyuanchallengebuffselectView.super.ctor(self)
end

function KingciyuanchallengebuffselectView:unbindEvents()
	KingciyuanchallengebuffselectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRefeesh)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnBuff)
end

function KingciyuanchallengebuffselectView:bindEvents()
	KingciyuanchallengebuffselectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnRefeesh, self._onClickRefresh, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBuff, self)
end

function KingciyuanchallengebuffselectView:buildUI()
	KingciyuanchallengebuffselectView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnRefeesh = self:getGo("btnRefeesh")
	self._btnSure = self:getGo("btnSure")
	self._btnBuff = self:getGo("btnBuff")
	self._txtCost = self:getTxt("txtCost")
	self._iconCost = self:getGo("txtCost/icon")

	local scrollerGo = self:getGo("tableview")
	local cellGo = self:getGo("buffCell")

	GameUtil.SetActive(cellGo, false)

	self._scrollList = ScrollerList.create(scrollerGo, cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function KingciyuanchallengebuffselectView:onExit()
	KingciyuanchallengebuffselectView.super.onExit(self)
	KingCiYuanChallengeController.instance:unregisterLocalNotify(KingCiYuanChallengeController.E_KingCiYuanGetInfoRes, self._invalidateAll, self)
	KingCiYuanChallengeController.instance:unregisterLocalNotify(KingCiYuanChallengeController.E_KingCiYuanStageChangeBuffRes, self._invalidateAll, self)
	self._scrollList:dispose()
	MaterialMgr.resetAll(self._iconCost)
end

function KingciyuanchallengebuffselectView:onEnter()
	KingciyuanchallengebuffselectView.super.onEnter(self)
	KingCiYuanChallengeController.instance:registerLocalNotify(KingCiYuanChallengeController.E_KingCiYuanGetInfoRes, self._invalidateAll, self)
	KingCiYuanChallengeController.instance:registerLocalNotify(KingCiYuanChallengeController.E_KingCiYuanStageChangeBuffRes, self._invalidateAll, self)

	self._activityId = checknumber(self:getFirstParam())

	local strCost = KingCiYuanChallengeConfig.instance:getCommonValue("BuffStageResetCost")
	local type, id, num = MaterialMgr.getMatParams(strCost)

	self._txtCost.text = tostring(num)

	local proxy = MaterialMgr.setCellByCfg(strCost, self._iconCost)

	if proxy then
		proxy.binder:setAutoTips(false)
		proxy.binder:setBgActive(false)
		proxy:setNumStr("")
		proxy:setCallBack(nil)
	end

	self:_invalidateAll()
end

function KingciyuanchallengebuffselectView:_invalidateAll()
	local selectBuffs = KingCiYuanChallengeModel.instance:getJxSelectBuffs() or {}
	local buffs = KingCiYuanChallengeModel.instance:getJxBuffs() or {}
	local buffMap = {}

	for _, data in ipairs(buffs) do
		buffMap[data.buffId] = data.count
	end

	local buffArray = {}

	for _, buffId in ipairs(selectBuffs) do
		local curLevel = checknumber(buffMap[buffId])
		local curConfig = KingCiYuanChallengeConfig.instance:getTagConfig(buffId, curLevel)
		local nextConfig = KingCiYuanChallengeConfig.instance:getTagConfig(buffId, curLevel + 1)

		table.insert(buffArray, {
			curConfig = curConfig,
			nextConfig = nextConfig
		})
	end

	self._configs = buffArray

	self:_onClickCell(nil)
end

function KingciyuanchallengebuffselectView:_updateCell(view, cell, data, tag)
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local select = goutil.findChild(cell, "select")
	local buffIcon = goutil.findChild(cell, "buffIcon")
	local btn = goutil.findChild(cell, "btn")
	local active = goutil.findChild(cell, "active")
	local unActive = goutil.findChild(cell, "unActive")
	local curConfig, nextConfig = data.curConfig, data.nextConfig
	local baseConfig = curConfig or nextConfig

	if curConfig then
		GameUtil.SetActive(unActive, false)
		GameUtil.SetActive(active, true)

		txtName.text = langPara("%s(等级%s)", curConfig.targetName, curConfig.level)

		self:_setByConfig(goutil.findChild(active, "now"), curConfig)
		self:_setByConfig(goutil.findChild(active, "next"), nextConfig)
	else
		GameUtil.SetActive(unActive, true)
		GameUtil.SetActive(active, false)

		txtName.text = langPara("%s(未激活)", nextConfig.targetName)

		self:_setByConfig(unActive, nextConfig)
	end

	GameUtil.SetActive(select, self._data == data)
	uGuiUtil.clearImage(buffIcon)
	uGuiUtil.setSpriteToImage(buffIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(baseConfig.iconPath))
	GameUtil.addClickHandler(btn, function()
		self:_onClickCell(data)
	end)
end

function KingciyuanchallengebuffselectView:_setByConfig(container, config)
	local txtLevel = goutil.findChildTextComponent(container, "txtLevel")
	local txtDesc = goutil.findChildTextComponent(container, "txtDesc")

	txtLevel.text = langPara("等级<color=#45FFB2FF>%s</color>", config.level)
	txtDesc.text = config.desc
end

function KingciyuanchallengebuffselectView:_clearCell(cell)
	local buffIcon = goutil.findChild(cell, "buffIcon")
	local btn = goutil.findChild(cell, "btn")

	uGuiUtil.clearImage(buffIcon)
	GameUtil.rmClickHandler(btn)
end

function KingciyuanchallengebuffselectView:_onClickCell(data)
	self._data = data

	GameUtil.SetGray(self._btnSure, self._data == nil)
	self._scrollList:reloadData(self._configs)
	self._scrollList:refresh()
end

function KingciyuanchallengebuffselectView:_onClickRefresh()
	local strCost = KingCiYuanChallengeConfig.instance:getCommonValue("BuffStageResetCost")
	local type, id, num = MaterialMgr.getMatParams(strCost)

	if MaterialFacade.instance:checkMatEnough(type, id, num) then
		KingCiYuanChallengeAgent.instance:sendPM_KingCiYuanStageChangeBuffReq(self._activityId)
	end
end

function KingciyuanchallengebuffselectView:_onClickSure()
	if self._data then
		local passStageId = KingCiYuanChallengeModel.instance:getJxPassStageId()

		KingCiYuanChallengeAgent.instance:sendPM_KingCiYuanStageActionReq(self._activityId, passStageId + 1, self._data.nextConfig.tagId)
		self:close()
	end
end

function KingciyuanchallengebuffselectView:_onClickBuff()
	UIStateManager.instance:push(ViewName.KingciyuanchallengebuffpopupView, self._activityId)
end

return KingciyuanchallengebuffselectView
