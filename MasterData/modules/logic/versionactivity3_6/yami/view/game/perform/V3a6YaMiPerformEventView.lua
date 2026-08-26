-- chunkname: @modules/logic/versionactivity3_6/yami/view/game/perform/V3a6YaMiPerformEventView.lua

module("modules.logic.versionactivity3_6.yami.view.game.perform.V3a6YaMiPerformEventView", package.seeall)

local V3a6YaMiPerformEventView = class("V3a6YaMiPerformEventView", BaseView)

function V3a6YaMiPerformEventView:onInitView()
	self._goemergencytips = gohelper.findChild(self.viewGO, "root/#go_emergencytips")
	self._txttitle = gohelper.findChildText(self.viewGO, "root/#go_emergencytips/txt_title")
	self._txtdesc = gohelper.findChildText(self.viewGO, "root/#go_emergencytips/#txt_desc")
	self._goattr = gohelper.findChild(self.viewGO, "root/#go_emergencytips/#go_attr")
	self._txtnum1 = gohelper.findChildText(self.viewGO, "root/#go_emergencytips/#go_attr/#txt_num1")
	self._txtnum2 = gohelper.findChildText(self.viewGO, "root/#go_emergencytips/#go_attr/#txt_num2")
	self._txtnum3 = gohelper.findChildText(self.viewGO, "root/#go_emergencytips/#go_attr/#txt_num3")
	self._txtnum4 = gohelper.findChildText(self.viewGO, "root/#go_emergencytips/#go_attr/#txt_num4")
	self._btnok = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_emergencytips/#btn_ok")
	self._txtok = gohelper.findChildText(self.viewGO, "root/#go_emergencytips/#btn_ok/txt_ok")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")
	self._gorighttop = gohelper.findChild(self.viewGO, "#go_righttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a6YaMiPerformEventView:addEvents()
	self._btnok:AddClickListener(self._btnokOnClick, self)
	self.addEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onMeetEvent, self._onMeetEvent, self)
end

function V3a6YaMiPerformEventView:removeEvents()
	self._btnok:RemoveClickListener()
	self.removeEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onMeetEvent, self._onMeetEvent, self)
end

function V3a6YaMiPerformEventView:_btnokOnClick()
	V3a6YaMiRpc.instance:sendAct231ContinueResearchRequest(self._onContinueResearch, self)
end

function V3a6YaMiPerformEventView:_onContinueResearch()
	V3a6YaMiController.instance:dispatchEvent(V3a6YaMiEvent.onFinishEvent)
	gohelper.setActive(self._goemergencytips, false)
end

function V3a6YaMiPerformEventView:_editableInitView()
	gohelper.setActive(self._goemergencytips, false)

	self._attrItems = self:getUserDataTb_()

	for _, type in pairs(V3a6YaMiEnum.AttrType) do
		local item = self:getUserDataTb_()

		item.txtnum = gohelper.findChildText(self.viewGO, "root/#go_emergencytips/#go_attr/#txt_num" .. type)
		item.go = item.txtnum.gameObject
		item.icon = gohelper.findChildImage(item.go, "image_icon")

		local _info = V3a6YaMiEnum.AttrInfo[type]

		UISpriteSetMgr.instance:setV3a6YaMiSprite(item.icon, _info.Icon)

		self._attrItems[type] = item
	end
end

function V3a6YaMiPerformEventView:_onMeetEvent(stepInfo)
	AudioMgr.instance:trigger(AudioEnum3_6.YaMi.play_ui_renmen_waiwei_tan2)

	if stepInfo then
		local co = V3a6YaMiConfig.instance:getEventCo(stepInfo.skillId)
		local effect = string.splitToNumber(co.effect, "#")

		for type, _ in pairs(V3a6YaMiEnum.AttrInfo) do
			local num = effect[type]
			local item = self._attrItems[type]
			local lang = luaLang("v3a6_yami_add_value")

			item.txtnum.text = num > 0 and GameUtil.getSubPlaceholderLuaLangOneParam(lang, num) or num

			local color = num > 0 and "#e99b56" or "#6384e5"

			item.txtnum.color = GameUtil.parseColor(color)
		end

		self._txtdesc.text = co.desc
		self._txttitle.text = co.name
		self._txtok.text = co.button
	end

	gohelper.setActive(self._goemergencytips, true)
end

function V3a6YaMiPerformEventView:onUpdateParam()
	return
end

function V3a6YaMiPerformEventView:onOpen()
	return
end

function V3a6YaMiPerformEventView:onClose()
	return
end

function V3a6YaMiPerformEventView:onDestroyView()
	return
end

return V3a6YaMiPerformEventView
