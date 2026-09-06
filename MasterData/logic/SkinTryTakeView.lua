-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firstannualwelfare/view/SkinTryTakeView.lua

module("logic.extensions.firstannualwelfare.view.SkinTryTakeView", package.seeall)

local SkinTryTakeView = class("SkinTryTakeView", ViewComponent)

function SkinTryTakeView:buildUI()
	SkinTryTakeView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._goCell = self:getGo("cell")
	self._goTableview = self:getGo("tableview")
	self._tableview = ScrollerList.create(self._goTableview, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function SkinTryTakeView:bindEvents()
	SkinTryTakeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self.onClickSure, self)
end

function SkinTryTakeView:unbindEvents()
	SkinTryTakeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function SkinTryTakeView:onEnter()
	SkinTryTakeView.super.onEnter(self)

	self._actId = self:getFirstParam()

	local skinCfgs = FirstAnnualWelfareConfig.instance:getSkinCfgs(self._actId)

	self._dataList = {}

	for _, v in pairs(skinCfgs) do
		table.insert(self._dataList, v)
	end

	self:_refreshView()
end

function SkinTryTakeView:onExit()
	SkinTryTakeView.super.onExit(self)
end

function SkinTryTakeView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)

	cell.txtName.text = MaterialMgr.getMaterialsName(MatType.PET_SKIN, data.skinId)
	cell.txtHaveCount.text = langPara("已拥有：%s", MaterialModel.instance:getMaterialsNumber(MatType.PET_SKIN, data.skinId))

	MaterialMgr.setCell(MatType.PET_SKIN, data.skinId, cell.item)
	goutil.setActive(cell.select, data.skinId == self._selectSkinId)
	GameUtil.addClickHandler(cell.go, GameUtil.handler(self._refreshView, self, data.skinId))
end

function SkinTryTakeView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell

	GameUtil.rmClickHandler(cell.go)

	cell.txtCount = goutil.findChildTextComponent(cell.go, "txtCount")
	cell.txtName = goutil.findChildTextComponent(cell.go, "txtName")
	cell.txtHaveCount = goutil.findChildTextComponent(cell.go, "txtHaveCount")
	cell.item = goutil.findChild(cell.go, "item")
	cell.select = goutil.findChild(cell.go, "imgSelect")

	MaterialMgr.resetAll(cell.item)

	cell.txtCount.text = "x1"

	return cell
end

function SkinTryTakeView:onClickSure()
	if not self._selectSkinId then
		FloatWordMgr.instance:show("当前未选中试用皮肤")
	else
		self:close()
		FirstAnnualWelfareController.instance:onSendFirstAnnualWelfareGainPetSkinReq(self._actId, self._selectSkinId)
	end
end

function SkinTryTakeView:_refreshView(skinId)
	if self._selectSkinId ~= skinId then
		local skinCfg = MaterialMgr.getMatCfg(MatType.PET_SKIN, skinId)

		if skinCfg and skinCfg.raceId and MaterialModel:getMaterialsNumber(MatType.Pet, skinCfg.raceId) > 0 then
			self._selectSkinId = skinId

			self._tableview:reloadData(self._dataList)
		else
			FloatWordMgr.instance:show("玩家未拥有这只精灵，无法领取试用皮肤")

			return
		end
	end

	if not self._selectSkinId then
		self._tableview:reloadData(self._dataList)
	end

	GameUtil.SetGray(self._btnSure, not self._selectSkinId)
end

return SkinTryTakeView
