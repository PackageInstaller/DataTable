-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/funcampmain/FunCampSelectView.lua

module("logic.extensions.funcamp.view.funcampmain.FunCampSelectView", package.seeall)

local FunCampSelectView = class("FunCampSelectView", ViewComponent)

function FunCampSelectView:ctor()
	FunCampSelectView.super.ctor(self)
end

function FunCampSelectView:buildUI()
	FunCampSelectView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._itemGos = {}

	for i = 1, 3 do
		local item = {}

		item.txtTitle = self:getTxt(string.format("camp_%d/title/txt", i))
		item.txtDesc = self:getTxt(string.format("camp_%d/txtDesc/Viewport/Content", i))
		item.btn = self:getBtn(string.format("camp_%d", i))
		item.icon = self:getGo(string.format("camp_%d/pet/con", i))

		table.insert(self._itemGos, item)
	end
end

function FunCampSelectView:bindEvents()
	FunCampSelectView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)

	for i, v in ipairs(self._itemGos) do
		v.btn:AddClickListener(function()
			local campId = i

			self:_onClickCamp(campId)
		end)
	end
end

function FunCampSelectView:unbindEvents()
	FunCampSelectView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()

	for i, v in ipairs(self._itemGos) do
		v.btn:RemoveClickListener()
	end
end

function FunCampSelectView:onEnter()
	FunCampSelectView.super.onEnter(self)

	self._activityId = FunCampModel.instance:getActivityId()
	self._cfgActivity = FunCampConfig.instance:getActivityCfg(self._activityId)
	self._groupId = self._cfgActivity.groupId

	self:_initCamps()
end

function FunCampSelectView:onExit()
	FunCampSelectView.super.onExit(self)
end

function FunCampSelectView:_onClickCamp(campId)
	if FunCampModel.instance:isLastSelectedCamp() then
		local lastGroupId, lastCampId = FunCampModel.instance:getLastSelectId()

		if lastGroupId == self._groupId and lastCampId == campId then
			FloatWordMgr.instance:show("不能选择和上一期一样的阵营哦~")

			return
		end
	end

	local cfg = FunCampConfig.instance:getCampGroupCfg(self._groupId, campId)

	if not cfg then
		return
	end

	local title = lang("选择阵营")
	local text = string.format("是否确认选择【%s】？\n（选择之后无法再更换阵营）", cfg.name)

	local function okFunc()
		FunCampAgent.instance:sendPM_CB_SelectCampReq(self._activityId, campId)
		self:close()
	end

	local alignment = UnityEngine.TextAnchor.MiddleCenter

	TipsFacade.instance:openPopupWindow(title, text, okFunc, nil, nil, nil, alignment)
end

function FunCampSelectView:_initCamps()
	for campId, v in ipairs(self._itemGos) do
		local cfg = FunCampConfig.instance:getCampGroupCfg(self._groupId, campId)

		if cfg then
			v.txtTitle.text = cfg.name
			v.txtDesc.text = cfg.desc

			uGuiUtil.setSpriteToImage(v.icon, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("funcamp", cfg.path))
		end
	end
end

return FunCampSelectView
