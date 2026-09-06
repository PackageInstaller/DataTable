-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilyListView.lua

module("logic.extensions.family.view.FamilyListView", package.seeall)

local FamilyListView = class("FamilyListView", TableViewComponent)

function FamilyListView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function FamilyListView:ctor()
	FamilyListView.super.ctor(self)
end

function FamilyListView:destroyUI()
	FamilyListView.super.destroyUI(self)
end

function FamilyListView:onExitFinished()
	FamilyListView.super.onExitFinished(self)
end

function FamilyListView:onEnterFinished()
	FamilyListView.super.onEnterFinished(self)
end

function FamilyListView:unbindEvents()
	FamilyListView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._inputField:RemoveOnValueChanged()
	self._btnHome:RemoveClickListener()
	self._btnRule:RemoveClickListener()
	self._btnCreate:RemoveClickListener()
	self._btnOneKey:RemoveClickListener()
	self._btnSearch:RemoveClickListener()
	self._btnBack:RemoveClickListener()
	self._tableview:RemoveScrollValueChanged()
	self._btnRule:RemoveClickListener()
end

function FamilyListView:bindEvents()
	FamilyListView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._inputField:SetCharacterLimit(30)
	self._btnHome:AddClickListener(self._onClickClose, self)
	self._btnRule:AddClickListener(self._onClickRule, self)
	self._btnCreate:AddClickListener(self._onClickCreate, self)
	self._btnOneKey:AddClickListener(self._onClickOneKey, self)
	self._btnSearch:AddClickListener(self._onClickSearch, self)
	self._btnBack:AddClickListener(self._onClickBack, self)
	self._btnRule:AddClickListener(function()
		self:_onClickRule("familylist")
	end)
end

function FamilyListView:onExit()
	FamilyListView.super.onExit(self)
end

function FamilyListView:buildUI()
	FamilyListView.super.buildUI(self)

	self._closeButton = self:getBtn("topleft/btn_close")
	self._btnHome = self:getBtn("topleft/btn_home")
	self._btnRule = self:getBtn("topleft/btn_rule")
	self._tipsNull = self:getGo("tipsNull")

	goutil.setActive(self._tipsNull.gameObject, false)

	self._btnCreate = self:getBtn("bomright/btnCreate")
	self._btnOneKey = self:getBtn("bomright/btnOneKey")
	self._inputField = Framework.InputFieldAdapter.GetFrom(self.mainGO, "bomleft/inputField")
	self._btnSearch = self:getBtn("bomleft/btnSearch")
	self._btnBack = self:getBtn("bomleft/btnBack")
	self._btnRule = self:getBtn("topleft/btn_rule")
end

function FamilyListView:onEnter()
	FamilyListView.super.onEnter(self)
	self.addGEvent(self, FamilyAgent.SearchFamilyRes, self._onSearchSuccess, self)
	self:_clearSearch()

	self._isFirst = true

	goutil.setActive(self._tableview.gameObject, false)
	goutil.setActive(self._tipsNull, false)
	FamilyController.instance:getFamilyViewsReq(self._updateFamilyList, self)
end

function FamilyListView:_onReloadFinish()
	if self._isFirst then
		self._isFirst = false

		self._tableview:SetOffset(0, false)
	end
end

function FamilyListView:_updateFamilyList()
	goutil.setActive(self._tableview.gameObject, true)

	self._curViewDatas = FamilyModel.instance:getFamilyList()

	self:reloadData()
	self._tableview:AddOnScrollValueChanged(self._onScrollValueChange, self)
end

function FamilyListView:_clearSearch()
	goutil.setActive(self._btnBack.gameObject, false)
	self._inputField:SetText("")
	goutil.setActive(self._tipsNull.gameObject, false)
end

function FamilyListView:_updateCell(view, cell, data)
	local container = goutil.findChild(cell.gameObject, "container")
	local imgSpriteChange = goutil.findChildComponent(container, "imgIcon", "UIImageSpriteChange")
	local txtId = goutil.findChildTextComponent(container, "txtId")
	local txtFamily = goutil.findChildTextComponent(container, "txtFamily")
	local txtLevel = goutil.findChildTextComponent(container, "txtLevel")
	local txtCapacity = goutil.findChildTextComponent(container, "txtCapacity")
	local txtCondition = goutil.findChildTextComponent(container, "txtCondition")
	local tag = goutil.findChild(container, "tag")
	local btnApply = Framework.ButtonAdapter.GetFrom(container, "btnApply")
	local btnCancle = Framework.ButtonAdapter.GetFrom(container, "btnCancle")

	imgSpriteChange:SetState(data.iconId)

	txtId.text = string.format("编号：%s", data.familyId)
	txtFamily.text = data.familyName
	txtLevel.text = data.level .. "级"

	local lvCfg = FamilyConfig.instance:getLvCfgByLv(data.level)

	txtCapacity.text = string.format("%s/%s", data.familyMemberCount, (lvCfg or nil) and (lvCfg.maxAllMemberCount or 0))

	FamilyFacade.instance:updateFamilyTag(tag, data.purpose)

	txtCondition.text = FamilyFacade.instance:getFamilyTagText(data, "\n")

	btnApply:AddClickListener(function()
		self:_onClickApply(data.familyId, data.dailyJoinCount)
	end)
	btnCancle:AddClickListener(function()
		self:_onClickCancle(data.familyId)
	end)

	local applyed = FamilyModel.instance:getFamilyViewApplied(data.familyId)

	goutil.setActive(btnApply.gameObject, not applyed)
	goutil.setActive(btnCancle.gameObject, applyed)
end

function FamilyListView:_cellSize()
	return 1025, 85
end

function FamilyListView:_onValueChanged(value)
	return
end

function FamilyListView:_onScrollValueChange(value)
	if value.y <= 0 and #self._curViewDatas >= FamilyConfig.instance:getApplyMaxNum() then
		FamilyController.instance:getFamilyViewsReq(self._updateFamilyList, self, true)
	end
end

function FamilyListView:_onClickCreate()
	if FamilyController.instance:checkCanApply(true) then
		UIStateManager.instance:push(ViewName.FamilySetting, true)
	end
end

function FamilyListView:_onClickOneKey()
	FamilyController.instance:oneKeyApplyJoinFamilyReq()
end

function FamilyListView:_onClickClose()
	self:close()
end

function FamilyListView:_onClickApply(familyId, dailyJoinCount)
	local joinLimit = FamilyConfig.instance:getCommonValue("DAILY_JOIN_LIMIT", true)

	if joinLimit > 0 and checknumber(dailyJoinCount) > 0 and joinLimit <= dailyJoinCount then
		FloatWordMgr.instance:show("该家族今日新增成员已达上限")
	else
		self._familyId = familyId

		FamilyController.instance:applyJoinFamilyReq(familyId, self._onApplyJoinSuccess, self)
	end
end

function FamilyListView:_onApplyJoinSuccess(msg)
	FloatWordMgr.instance:show("申请成功")
	self:_updateCellByFamilyId(self._familyId)
end

function FamilyListView:_updateCellByFamilyId(familyId)
	for k, v in ipairs(self._curViewDatas) do
		if v.familyId == familyId then
			self._tableview:UpdateCellAtIndex(k - 1)
		end
	end
end

function FamilyListView:_onClickCancle(familyId)
	self._familyId = familyId

	FamilyController.instance:cancelApplyJoinReq(familyId, self._onCancleApplySuccess, self)
end

function FamilyListView:_onCancleApplySuccess()
	FloatWordMgr.instance:show("取消成功")
	self:_updateCellByFamilyId(self._familyId)
end

function FamilyListView:_onClickSearch()
	local text = self._inputField:GetText()

	if string.nilorempty(text) then
		FloatWordMgr.instance:show("输入内容不能为空")
	else
		FamilyController.instance:sendSearchFamilyReq(text)
	end
end

function FamilyListView:_onSearchSuccess()
	local msg = FamilyModel.instance:getSearchFamilyInfo()

	self._curViewDatas = {}

	if msg.searchResult and checknumber(msg.searchResult.familyId) > 0 then
		table.insert(self._curViewDatas, msg.searchResult)
	end

	self._tableview:RemoveScrollValueChanged()
	self:reloadData()
	goutil.setActive(self._btnBack.gameObject, true)
	goutil.setActive(self._tipsNull.gameObject, #self._curViewDatas == 0)
end

function FamilyListView:_onClickBack()
	self:_clearSearch()
	self:_updateFamilyList()
end

function FamilyListView:_onClickRule(key)
	UIStateManager.instance:open(ViewName.RulesView, key)
end

return FamilyListView
