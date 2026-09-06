-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilyAssignView.lua

module("logic.extensions.family.view.FamilyAssignView", package.seeall)

local FamilyAssignView = class("FamilyAssignView", ViewComponent)

function FamilyAssignView:ctor()
	FamilyAssignView.super.ctor(self)
end

function FamilyAssignView:destroyUI()
	FamilyAssignView.super.destroyUI(self)
end

function FamilyAssignView:onExitFinished()
	FamilyAssignView.super.onExitFinished(self)
end

function FamilyAssignView:onEnterFinished()
	FamilyAssignView.super.onEnterFinished(self)
end

function FamilyAssignView:unbindEvents()
	FamilyAssignView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnSure:RemoveClickListener()
	self._btnCancle:RemoveClickListener()
end

function FamilyAssignView:bindEvents()
	FamilyAssignView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnSure:AddClickListener(self._onClickSure, self)
	self._btnCancle:AddClickListener(self._onClickClose, self)
end

function FamilyAssignView:onExit()
	FamilyAssignView.super.onExit(self)
end

function FamilyAssignView:buildUI()
	FamilyAssignView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._txtName = goutil.findChildTextComponent(self.mainGO, "txtName")

	local btns = self:getGo("btns")

	self._btns = ItemGroup.New(btns, nil, function(go, item)
		item.txtNum = goutil.findChildTextComponent(go, "num")
		item.btn = Framework.ButtonAdapter.Get(go)
		item.imgChange = goutil.findChildComponent(go, "image", "UIImageSpriteChange")
		item.imgColorChange = goutil.findChildComponent(go, "image", "UIImageColorChange")

		item.btn:AddClickListener(function()
			self:_onClickBtn(item.index - 1)
		end)
	end)
	self._btnSure = self:getBtn("btnSure")
	self._btnCancle = self:getBtn("btnCancel")
	self._txtName = goutil.findChildTextComponent(self.mainGO, "txtName")
end

function FamilyAssignView:onEnter()
	FamilyAssignView.super.onEnter(self)

	self._mo = self:getFirstParam()

	local role = FamilyModel.instance:getMyRole()

	self._txtName.text = self._mo.simpleInfo.userName
	self._selectedRole = -1

	self._btns:updateWithNoCreate(5, function(item, index)
		local curRole = index - 1
		local hasAuthority = FamilyConfig.instance:isHasAuthority("APPOINT_DISMISS_" .. curRole, role)

		goutil.setActive(item.btn.gameObject, hasAuthority)

		local isSelected = self._selectedRole == index - 1

		item.imgChange:SetState(isSelected and 1 or 0)
		item.imgColorChange:SetState(isSelected and 1 or 0)

		if item.txtNum then
			local curNum = FamilyModel.instance:getRoleCount(curRole)
			local lv = FamilyModel.instance:getFamilyLv()
			local maxNum = FamilyConfig.instance:getMaxRoleCount(lv, curRole)

			item.txtNum.text = string.format("（%s/%s）", curNum, maxNum)

			local r, g, b

			if curNum < maxNum then
				b = 56
				g = 178
				r = 43
			else
				b = 143
				g = 128
				r = 124
			end

			Game.TextUtil.SetColorRGBA(item.txtNum, r / 255, g / 255, b / 255, 1)
		end
	end)
end

function FamilyAssignView:_onClickClose()
	self:close()
end

function FamilyAssignView:_onClickBtn(role)
	self._selectedRole = role

	local myRole = FamilyModel.instance:getMyRole()

	self._btns:updateWithNoCreate(5, function(item, index)
		local curRole = index - 1
		local hasAuthority = FamilyConfig.instance:isHasAuthority("APPOINT_DISMISS_" .. curRole, myRole)

		goutil.setActive(item.btn.gameObject, hasAuthority)

		local isSelected = self._selectedRole == index - 1

		item.imgChange:SetState(isSelected and 1 or 0)
		item.imgColorChange:SetState(isSelected and 1 or 0)
	end)
end

function FamilyAssignView:_onClickSure()
	if self._selectedRole < 0 then
		FloatWordMgr.instance:show("请选中要任命的职位")
	elseif self:_checkChangeRoleCd() then
		if self._selectedRole == 0 then
			local content = string.format("您确定要将族长职位让给[%s]？", self._mo.simpleInfo.userName)

			TipsFacade.instance:openPopupWindow("提示", content, function()
				self:reqChangeRole()
			end)
		else
			self:reqChangeRole()
		end
	end
end

function FamilyAssignView:_checkChangeRoleCd()
	local lastChangeRoleTime = checknumber(self._mo.lastChangeRoleTime)
	local changeRoleCd = checknumber(FamilyConfig.instance:getCommonValue("CHANGE_ROLE_CD_HOUR"))
	local leftTime = changeRoleCd * 3600 + lastChangeRoleTime / 1000 - ServerTime.now()

	if lastChangeRoleTime < 0 or leftTime < 0 then
		return true
	else
		local content = string.format("最近已修改过成员职位,请%s后再修改", TimeUtil.getTimeFormat(leftTime))

		FloatWordMgr.instance:show(content)

		return false
	end
end

function FamilyAssignView:reqChangeRole()
	FamilyController.instance:changeFamilyRoleReq(self._mo.simpleInfo.userId, self._selectedRole, self._onChangeRoleSuccess, self)
end

function FamilyAssignView:_onChangeRoleSuccess()
	local content = string.format("[%s]已被任命为%s职位！", self._mo.simpleInfo.userName, lang("tip_family_position_" .. self._selectedRole))

	FloatWordMgr.instance:show(content)
	self:close()
	ViewMgr.instance:close(ViewName.FamilyMemberInfo)
end

return FamilyAssignView
