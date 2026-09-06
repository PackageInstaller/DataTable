-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscompetition/view/GoddessCompetitionSendPackMainView.lua

module("logic.extensions.goddesscompetition.view.GoddessCompetitionSendPackMainView", package.seeall)

local GoddessCompetitionSendPackMainView = class("GoddessCompetitionSendPackMainView", ViewComponent)

function GoddessCompetitionSendPackMainView:ctor()
	GoddessCompetitionSendPackMainView.super.ctor(self)
end

function GoddessCompetitionSendPackMainView:unbindEvents()
	GoddessCompetitionSendPackMainView.super.unbindEvents(self)
end

function GoddessCompetitionSendPackMainView:bindEvents()
	GoddessCompetitionSendPackMainView.super.bindEvents(self)
end

function GoddessCompetitionSendPackMainView:buildUI()
	GoddessCompetitionSendPackMainView.super.buildUI(self)

	self._packTableCell = self:getGo("packTableCell")
	self._pcakTableView = self:getGo("pcakTableView")
	self._packTabList = ScrollerList.create(self._pcakTableView, self._packTableCell, GameUtil.handler(self._updatePackCell, self), GameUtil.handler(self._clearPackCell, self))
	self._goldBarCon = self:getGo("goldBarCon")
	self._txtRedPack = self:getTxt("txtRedPack")
end

function GoddessCompetitionSendPackMainView:onExit()
	GoddessCompetitionSendPackMainView.super.onExit(self)
	self._packTabList:dispose()
end

function GoddessCompetitionSendPackMainView:onEnter()
	GoddessCompetitionSendPackMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_GoddessCompetitionSendRedPackRes, self._refreshView, self)

	self._activityId = GoddessCompetitionModel.instance:getCurActId()

	self:_refreshView()
	self:_setTopGoldBar()
end

function GoddessCompetitionSendPackMainView:_refreshView()
	local redPackCfgs = GoddessCompetitionConfig.instance:getRedPackCfgs(self._activityId)
	local redPackCfgList = {}

	for i, v in ipairs(redPackCfgs) do
		table.insert(redPackCfgList, v)
	end

	table.sort(redPackCfgList, function(a, b)
		local aSendCount = GoddessCompetitionModel.instance:getRedPackSendCount(a.redPackId)
		local aSendAll = aSendCount >= a.dailySendTimesLimit
		local bSendCount = GoddessCompetitionModel.instance:getRedPackSendCount(b.redPackId)
		local bSendAll = bSendCount >= b.dailySendTimesLimit

		if aSendAll == bSendAll then
			return a.redPackId < b.redPackId
		else
			return bSendAll
		end
	end)
	self._packTabList:reloadData(redPackCfgList)

	local redPcakTips = lang("红包发放 ：")

	for i, v in ipairs(redPackCfgs) do
		local havePack = v.dailySendTimesLimit - GoddessCompetitionModel.instance:getRedPackSendCount(v.redPackId)
		local showColor = havePack > 0 and "#73FFC5" or "#eb4642"

		redPcakTips = redPcakTips .. langPara("%s <color=%s>%d</color>/%d ", v.name, showColor, havePack, v.dailySendTimesLimit)
	end

	self._txtRedPack.text = redPcakTips
end

function GoddessCompetitionSendPackMainView:_setTopGoldBar()
	local btn_list = {}

	table.insert(btn_list, {
		showAdd = false,
		id = GameEnum.GoldType.Diamond
	})
	table.insert(btn_list, {
		showAdd = false,
		id = GameEnum.GoldType.GodDiamondCoin
	})
	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list, false)
end

function GoddessCompetitionSendPackMainView:_updatePackCell(view, cell, data, tag)
	local go = cell.gameObject
	local img = goutil.findChild(go, "img")
	local type1 = goutil.findChild(go, "type1")
	local type2 = goutil.findChild(go, "type2")
	local goType = type1

	goutil.setActive(type1, false)
	goutil.setActive(type2, false)

	if data.type == 2 then
		goType = type2
	end

	goutil.setActive(goType, true)

	local txtTitle = goutil.findChildTextComponent(goType, "txtTitle")
	local txtNum = goutil.findChildTextComponent(goType, "txtNum")
	local txtDesc = goutil.findChildTextComponent(goType, "txtDesc")
	local con = goutil.findChild(goType, "con")
	local matType, matId, matNum = MaterialMgr.getMatParams(data.sendCost)

	MaterialMgr.setIcon(con, matType, matId)

	txtNum.text = matNum
	txtDesc.text = langPara("%d个红包\n为女神增加%d人气", data.gainCount, data.incPopularity)
	txtTitle.text = data.name

	local imgPath = string.split(data.imgPath, "#")
	local showImg = imgPath[3]

	uGuiUtil.clearImage(img)
	uGuiUtil.setSpriteToImage(img, uGuiUtil.SpriteType.BigBg, GameUrl.getGoddessRedpackUrl(showImg))
	GameUtil.rmClickHandler(go)
	GameUtil.addClickHandler(go, function()
		self:_onClickRedPack(data.redPackId)
	end)
end

function GoddessCompetitionSendPackMainView:_clearPackCell(cell)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")

	GameUtil.rmClickHandler(go)
	MaterialMgr.resetAll(con)
end

function GoddessCompetitionSendPackMainView:_onClickRedPack(redPackId)
	local redPackCfg = GoddessCompetitionConfig.instance:getRedPackCfg(self._activityId, redPackId)
	local havePack = redPackCfg.dailySendTimesLimit - GoddessCompetitionModel.instance:getRedPackSendCount(redPackId) > 0

	if havePack == true then
		UIStateManager.instance:push(ViewName.GoddessCompetitionSendRedPackView, self._activityId, redPackId)
	else
		FloatWordMgr.instance:show(lang("此红包今日已无发送次数"))
	end
end

return GoddessCompetitionSendPackMainView
