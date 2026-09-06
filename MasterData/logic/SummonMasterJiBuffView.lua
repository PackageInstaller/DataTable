-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summonmasterji/view/SummonMasterJiBuffView.lua

module("logic.extensions.summonmasterji.view.SummonMasterJiBuffView", package.seeall)

local SummonMasterJiBuffView = class("SummonMasterJiBuffView", ViewComponent)

function SummonMasterJiBuffView:ctor()
	SummonMasterJiBuffView.super.ctor(self)
end

function SummonMasterJiBuffView:buildUI()
	SummonMasterJiBuffView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnGo = self:getBtn("btnGo")
	self._btnSure = self:getBtn("btnSure")
	self._txtDesc = self:getTxt("txtDesc")
end

function SummonMasterJiBuffView:bindEvents()
	SummonMasterJiBuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnGo, self._onClickGo, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)

	self.scrollerGo = self:getGo("tableview")
	self.cellGo = self:getGo("tablecell")
	self._scrollList = ScrollerList.create(self.scrollerGo, self.cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function SummonMasterJiBuffView:unbindEvents()
	SummonMasterJiBuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnGo)
	GameUtil.rmClickHandler(self._btnSure)
end

function SummonMasterJiBuffView:onEnter()
	SummonMasterJiBuffView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._blessingId = params[2]
	self._durationDays = SummonMasterJiModel.instance:getActivityLoginDays(self._activityId)
	self._txtDesc.text = string.format("当前活动已签到%d天", self._durationDays)
	self._selectBlessingId = self._blessingId

	self:_initBuffs()
	SummonMasterJiController.instance:markNormalBuffDailyRedPoint(self._activityId)
end

function SummonMasterJiBuffView:onExit()
	SummonMasterJiBuffView.super.onExit(self)
	self._scrollList:dispose()
end

function SummonMasterJiBuffView:_onClickClose()
	self:close()
end

function SummonMasterJiBuffView:_onClickGo()
	self:close()
	FuncOpenController.instance:openFunc(FuncConst.DiamondTask)
end

function SummonMasterJiBuffView:_onClickSure()
	SummonMasterJiController.instance:localNotify(SummonMasterJiController.SelectBuffFinishEvent, self._selectBlessingId)
	self:close()
end

function SummonMasterJiBuffView:_updateCell(view, cell, data, tag)
	local icon = goutil.findChild(cell, "btn/icon")
	local image = icon:GetComponent(goutil.Type_UIImage)
	local txtName = goutil.findChildTextComponent(cell, "btn/txtName")
	local txtDesc = goutil.findChildTextComponent(cell, "btn/txtDesc")
	local txtLock = goutil.findChildTextComponent(cell, "btn/lock/txt")
	local usingGo = goutil.findChild(cell, "btn/using")
	local lockGo = goutil.findChild(cell, "btn/lock")
	local selectGo = goutil.findChild(cell, "btn/select")
	local btn = goutil.findChild(cell, "btn")
	local blessingId = data.cfg.blessingId

	GameUtil.addClickHandler(btn, GameUtil.handler(self._onClickCell, self, blessingId))
	uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, data.cfgBuff.iconPath)

	txtName.text = data.cfgBuff.name
	txtDesc.text = data.cfgBuff.desc

	GameUtil.SetActive(selectGo, data.isSelect)
	GameUtil.SetActive(usingGo, self._blessingId == data.cfg.blessingId)
	GameUtil.SetActive(lockGo, self._durationDays < data.cfg.unlockDays)

	txtLock.text = string.format("第%d日获得", data.cfg.unlockDays)

	if self._durationDays < data.cfg.unlockDays then
		Game.ImageUtil.SetColorRGBA(image, 0.47058823529411764, 0.47058823529411764, 0.47058823529411764, 1)
	else
		Game.ImageUtil.SetColorRGBA(image, 1, 1, 1, 1)
	end
end

function SummonMasterJiBuffView:clearCell(cell)
	local icon = goutil.findChild(cell, "btn/icon")

	uGuiUtil.clearImage(icon)
end

function SummonMasterJiBuffView:_onClickCell(blessingId)
	self._selectBlessingId = blessingId

	local curViewDatas = self._scrollList:getData()

	for i, v in ipairs(curViewDatas) do
		v.isSelect = v.cfg.blessingId == blessingId
	end

	self._scrollList:refresh()
	self:_updateBtns()
end

function SummonMasterJiBuffView:_initBuffs()
	local cfgs = SummonMasterJiConfig.instance:getBlessingList(self._activityId)
	local list = {}

	if self._blessingId > 0 then
		self._selectBlessingId = self._blessingId or 1
	end

	for i, v in ipairs(cfgs) do
		local info = {}

		info.isSelect = self._selectBlessingId == v.blessingId
		info.cfg = v
		info.cfgBuff = SummonMasterJiConfig.instance:getBuffCfg(v.buffId)

		table.insert(list, info)
	end

	self._scrollList:reloadData(list)
	self:_updateBtns()
end

function SummonMasterJiBuffView:_updateBtns()
	local cfg = SummonMasterJiConfig.instance:getBlessingCfg(self._activityId, self._selectBlessingId)
	local isUnlock = self._durationDays >= cfg.unlockDays

	GameUtil.SetActive(self._btnSure, isUnlock)
	GameUtil.SetActive(self._btnGo, false)
end

return SummonMasterJiBuffView
