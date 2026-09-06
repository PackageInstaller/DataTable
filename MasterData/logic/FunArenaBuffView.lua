-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funarena/view/FunArenaBuffView.lua

module("logic.extensions.funarena.view.FunArenaBuffView", package.seeall)

local FunArenaBuffView = class("FunArenaBuffView", ViewComponent)

function FunArenaBuffView:ctor()
	FunArenaBuffView.super.ctor(self)
end

function FunArenaBuffView:buildUI()
	FunArenaBuffView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "buff/btnClose")
	self._btnGet = goutil.findChild(self.mainGO, "buff/btnGet")
	self._buffCellList = {}
end

function FunArenaBuffView:bindEvents()
	FunArenaBuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
	GameUtil.addClickHandler(self._btnGet, self._onClickBtnGet, self)
end

function FunArenaBuffView:unbindEvents()
	FunArenaBuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnGet)
end

function FunArenaBuffView:onEnter()
	FunArenaBuffView.super.onEnter(self)

	self._activityId = FunArenaModel.instance.activityId
	self._buffCfgs = FunArenaConfig.instance:getBuffCfgs()

	local canGainBuffIds = FunArenaModel.instance._infoRes.canGainBuffIds

	if self._activityId == 0 or #canGainBuffIds == 0 then
		self:_onClickBtnClose()

		return
	end

	self._selectBUffId = 0

	self:_setPlaneUI()
	self:_buildBuffCells()
	self:_updateBuffCells()
end

function FunArenaBuffView:onExit()
	FunArenaBuffView.super.onExit(self)
	UIEffectManager.instance:stopEffect(self._effSelect)

	for _, cell in ipairs(self._buffCellList) do
		if cell._buffIcon then
			uGuiUtil.clearImage(cell._buffIcon)
		end
	end
end

function FunArenaBuffView:_setPlaneUI()
	local path = "fx_ui_yuanzheng/fx_ui_yuanzheng_xuanka.prefab"

	local function callBack(target, eff)
		eff:setParent(nil)
		eff:setLocalPos(0, 0, 0)
		eff:setScale(1, 1, 1)
		GameUtil.SetActive(eff.effGo, false)
	end

	self._effSelect = UIEffectManager.instance:playEffect(self, path, nil, 0, 0, true, false, nil, callBack, nil)
end

function FunArenaBuffView:_onClickBtnClose()
	self:close()
end

function FunArenaBuffView:_onClickBtnGet()
	local activityId = self._activityId
	local buffId = self._selectBUffId

	if buffId == 0 then
		return
	end

	self:_onClickBtnClose()
	FunArenaController.instance:onSendChooseBuffReq(activityId, buffId)
end

function FunArenaBuffView:_buildBuffCells()
	local canGainBuffIds = FunArenaModel.instance._infoRes.canGainBuffIds

	for i, buffId in ipairs(canGainBuffIds) do
		local data = self._buffCfgs[buffId]

		if data then
			cell = self:_buildBuffCell(i, data)

			if cell ~= nil then
				table.insert(self._buffCellList, cell)
			end
		end
	end
end

function FunArenaBuffView:_buildBuffCell(index, data)
	local go = goutil.findChild(self.mainGO, "buff/cell" .. index)

	if go == nil then
		return nil
	end

	local cell = {}

	cell._mainGo = go
	cell._btn = goutil.findChild(cell._mainGo, "btn")
	cell._buffIcon = goutil.findChild(cell._mainGo, "buffIcon")
	cell._txtName = goutil.findChildTextComponent(cell._mainGo, "txtName")
	cell._txtDesc = goutil.findChildTextComponent(cell._mainGo, "txtDesc")
	cell._tag = goutil.findChild(cell._mainGo, "tag")
	cell._txtTag = goutil.findChildTextComponent(cell._mainGo, "tag/txt")
	cell.data = data

	GameUtil.addClickHandler(cell._btn, GameUtil.handler(self._onClickBuffBtn, self, cell))

	return cell
end

function FunArenaBuffView:_updateBuffCells()
	for _, cell in ipairs(self._buffCellList) do
		self:_updateBuffCell(cell)
	end
end

function FunArenaBuffView:_updateBuffCell(cell)
	local data = cell.data

	if cell._txtName then
		cell._txtName.text = data.name
	end

	if cell._txtDesc then
		cell._txtDesc.text = data.desc
	end

	local isNeedSetIcon = not string.nilorempty(data.buffRes) and cell._buffIcon

	if isNeedSetIcon then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("ui/icon/expevents/%s.png", data.buffRes)

		local function func()
			return
		end

		uGuiUtil.setSpriteToImage(cell._buffIcon, spriteType, spriteName, func)
	end

	GameUtil.SetActive(cell._tag, data.type == 2)
end

function FunArenaBuffView:_onClickBuffBtn(cell)
	local eff = self._effSelect

	if eff and eff.effGo then
		eff:setClipping(cell._mainGo:GetComponent(goutil.Type_RectTransform))
		eff:setParent(cell._mainGo.transform)
		eff:setLocalPos(0, 0, 0)
		eff:setScale(1, 1, 1)
		GameUtil.SetActive(eff.effGo, true)
	end

	self._selectBUffId = cell.data.buffId
end

return FunArenaBuffView
