-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magicschool/view/MagicSchoolChooseBuffView.lua

module("logic.extensions.magicschool.view.MagicSchoolChooseBuffView", package.seeall)

local MagicSchoolChooseBuffView = class("MagicSchoolChooseBuffView", ViewComponent)

function MagicSchoolChooseBuffView:ctor()
	MagicSchoolChooseBuffView.super.ctor(self)
end

function MagicSchoolChooseBuffView:unbindEvents()
	MagicSchoolChooseBuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function MagicSchoolChooseBuffView:bindEvents()
	MagicSchoolChooseBuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function MagicSchoolChooseBuffView:buildUI()
	MagicSchoolChooseBuffView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function MagicSchoolChooseBuffView:onExit()
	MagicSchoolChooseBuffView.super.onExit(self)
	self._scrollList:dispose()
end

function MagicSchoolChooseBuffView:onEnter()
	MagicSchoolChooseBuffView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_MagicSchoolSelectBuffRes, self._onSelectBuffRes, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 514001
	end

	self._campId = checknumber(params[2])
	self._info = MagicSchoolModel.instance:getInfo(self._activityId)
	self._curSelectBuffId = self._info and checknumber(self._info.curSelectBuffId) or 0
	self._actCfg = MagicSchoolConfig.instance:getActCfg(self._activityId)
	self._buffCfgs = MagicSchoolConfig.instance:getBuffCfgsByCampId(self._activityId, self._campId)

	self._scrollList:reloadData(self._buffCfgs)
end

function MagicSchoolChooseBuffView:_updateCell(view, cell, data)
	local btnChoose = goutil.findChild(cell, "btnChoose")
	local iconBuff = goutil.findChild(cell, "BuffIcon")
	local usingGo = goutil.findChild(cell, "using")
	local lockGo = goutil.findChild(cell, "lock")
	local gouxuanGo = goutil.findChild(cell, "gouxuan/img")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtLock = goutil.findChildTextComponent(cell, "lock/txtLock")
	local txtDesc = goutil.findChildTextComponent(cell, "View/Viewport/Content/txtDesc")
	local curSelectBuffId = checknumber(self._info.curSelectBuffId)
	local playerLevel = MagicSchoolController.instance:getPlayerLevel(self._activityId, self._campId)
	local buffIconPath = string.format("ui/icon/%s.png", data.iconUrl)

	txtDesc.text = data.desc
	txtName.text = data.name
	txtLock.text = string.format("魔法师等级达到%d级解锁", data.unlockLv)

	uGuiUtil.setSpriteToImage(iconBuff, uGuiUtil.SpriteType.BigBg, buffIconPath)
	GameUtil.SetActive(lockGo, playerLevel < data.unlockLv)
	GameUtil.SetActive(gouxuanGo, self._curSelectBuffId == data.buffId)
	GameUtil.SetActive(usingGo, self._curSelectBuffId == data.buffId)
	GameUtil.addClickHandler(btnChoose, GameUtil.handler(self._onClickBtnChoose, self, data))
end

function MagicSchoolChooseBuffView:_clearCell(cell)
	local btnChoose = goutil.findChild(cell, "btnChoose")
	local iconBuff = goutil.findChild(cell, "BuffIcon")

	uGuiUtil.clearImage(iconBuff)
	GameUtil.rmClickHandler(btnChoose)
end

function MagicSchoolChooseBuffView:_onSelectBuffRes()
	self._scrollList:reloadData(self._buffCfgs)
end

function MagicSchoolChooseBuffView:_onClickBtnChoose(cfg)
	local playerLevel = MagicSchoolController.instance:getPlayerLevel(self._activityId, self._campId)

	if playerLevel < cfg.unlockLv then
		FloatWordMgr.instance:show("等级不足，无法选择当前buff")

		return
	end

	if cfg.buffId == self._curSelectBuffId then
		return
	end

	self._curSelectBuffId = cfg.buffId

	MagicSchoolController.instance:sendPM_MagicSchoolSelectBuffReq(self._activityId, self._curSelectBuffId)
end

return MagicSchoolChooseBuffView
