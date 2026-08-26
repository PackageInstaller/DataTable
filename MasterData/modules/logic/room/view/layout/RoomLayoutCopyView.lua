-- chunkname: @modules/logic/room/view/layout/RoomLayoutCopyView.lua

module("modules.logic.room.view.layout.RoomLayoutCopyView", package.seeall)

local RoomLayoutCopyView = class("RoomLayoutCopyView", RoomLayoutInputBaseView)

function RoomLayoutCopyView:_btncloseOnClick()
	self:closeThis()
	self:_closeInvokeCallback(false)
end

function RoomLayoutCopyView:_btnsureOnClick()
	local inputStr = self._inputsignature:GetText()

	if string.nilorempty(inputStr) then
		GameFacade.showToast(RoomEnum.Toast.LayoutRenameEmpty)
	else
		if not self.viewParam or self.viewParam.yesBtnNotClose ~= true then
			self:closeThis()
		end

		self:_closeInvokeCallback(true, inputStr)
	end
end

function RoomLayoutCopyView:_editableInitView()
	RoomLayoutCopyView.super._editableInitView(self)

	self._hyperLinkClick2 = self._txtdes.gameObject:GetComponent(typeof(ZProj.TMPHyperLinkClick))

	self._hyperLinkClick2:SetClickListener(self._onHyperLinkClick, self)

	self._groupMessage = gohelper.findChildComponent(self.viewGO, "message", gohelper.Type_VerticalLayoutGroup)
end

function RoomLayoutCopyView:_refreshInitUI()
	if self.viewParam then
		if not self.viewParam.playerName then
			local playerName = ""

			self._txttitlecn.text = formatLuaLang("room_layoutplan_copy_title", playerName)
			self._txttitleen.text = luaLang("room_layoutplan_copy_title_en")
			self._txtbtnsurecn.text = luaLang("room_layoutplan_copy_btn_confirm_txt")

			if self.viewParam then
				local defaultName = self.viewParam.defaultName

				if string.nilorempty(defaultName) then
					self._inputsignature:SetText("")
				else
					self._inputsignature:SetText(defaultName)
				end

				local desStr = self:_getDesStr(self.viewParam.planInfo)

				if desStr ~= nil then
					self._txtdes.text = desStr
					self._groupMessage.enabled = false

					TaskDispatcher.runDelay(self._onDelayShowMessage, self, 0.01)
				end
			end
		end
	end
end

function RoomLayoutCopyView:_onDelayShowMessage()
	self._groupMessage.enabled = true
end

function RoomLayoutCopyView:_onHyperLinkClick(str)
	RoomLayoutController.instance:openCopyTips(self.viewParam.planInfo)
end

function RoomLayoutCopyView:_getDesStr(planInfo)
	local packageNum, roleBirthdayNum, buildingNum, strList = RoomLayoutHelper.comparePlanInfo(planInfo)

	if #strList > 0 then
		local collStrList = {}

		self:_addCollStrList("room_layoutplan_blockpackage_lack", packageNum, collStrList)
		self:_addCollStrList("room_layoutplan_birthdayblock_lack", roleBirthdayNum, collStrList)
		self:_addCollStrList("room_layoutplan_building_lack", buildingNum, collStrList)

		local connchar = luaLang("room_levelup_init_and1")
		local lastConnchar = luaLang("room_levelup_init_and2")
		local desStr = self:_connStrList(strList, connchar, lastConnchar, RoomEnum.LayoutCopyShowNameMaxCount)
		local collectStr = self:_connStrList(collStrList, connchar, lastConnchar)
		local tag = {
			desStr,
			collectStr
		}

		return GameUtil.getSubPlaceholderLuaLang(luaLang("room_layoutplan_copy_lack_desc"), tag)
	end

	return nil
end

function RoomLayoutCopyView:_addCollStrList(langKey, needNum, collStrList)
	if needNum > 0 then
		table.insert(collStrList, formatLuaLang(langKey, needNum))
	end
end

function RoomLayoutCopyView:_connStrList(strList, connchar, lastConnchar, maxCount)
	return RoomLayoutHelper.connStrList(strList, connchar, lastConnchar, maxCount)
end

function RoomLayoutCopyView:onDestroyView()
	RoomLayoutCopyView.super.onDestroyView(self)
	TaskDispatcher.cancelTask(self._onDelayShowMessage, self)
end

return RoomLayoutCopyView
