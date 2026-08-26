-- chunkname: @modules/logic/versionactivity2_6/dicehero/view/DiceHeroLevelView.lua

module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroLevelView", package.seeall)

local DiceHeroLevelView = class("DiceHeroLevelView", BaseView)

function DiceHeroLevelView:onInitView()
	self._gonormal = gohelper.findChild(self.viewGO, "#go_Normal")
	self._goinfinite = gohelper.findChild(self.viewGO, "#go_Endless")
	self._btnReset = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Reset")
	self._txtTitle1 = gohelper.findChildTextMesh(self.viewGO, "#go_Normal/Title/#txt_Title")
	self._txtTitle2 = gohelper.findChildTextMesh(self.viewGO, "#go_Endless/Title/#txt_Title")
end

function DiceHeroLevelView:addEvents()
	self._btnReset:AddClickListener(self._onResetClick, self)
end

function DiceHeroLevelView:removeEvents()
	self._btnReset:RemoveClickListener()
end

function DiceHeroLevelView:_onResetClick()
	MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.DiceHeroReset, MsgBoxEnum.BoxType.Yes_No, self._onSendReset, nil, nil, self)
end

function DiceHeroLevelView:_onSendReset()
	DiceHeroRpc.instance:sendDiceGiveUp(5)
end

function DiceHeroLevelView:onOpen()
	AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_alaifuchapter)
	gohelper.setActive(self._gonormal, not self.viewParam.isInfinite)
	gohelper.setActive(self._goinfinite, self.viewParam.isInfinite)
	gohelper.setActive(self._btnReset, self.viewParam.isInfinite)

	local roleitemPath = self.viewContainer._viewSetting.otherRes.roleinfoitem

	if self.viewParam then
		if not self.viewParam.chapterId then
			local chapter = 1

			for i = 1, 6 do
				local go = gohelper.findChild(self.viewGO, "#btn_stage" .. i)
				local room = i
				local co = DiceHeroConfig.instance:getLevelCo(chapter, room)

				if not co then
					break
				end

				local comp = MonoHelper.addNoUpdateLuaComOnceToGo(go, DiceHeroStageItem)

				comp:initData(co, self.viewParam.isInfinite)

				if i == 1 then
					self._txtTitle1.text = co.chapterName
					self._txtTitle2.text = co.chapterName
				end
			end

			local roleGo = gohelper.findChild(self.viewGO, "#go_roleinfoitem")
			local roleInstGo = self:getResInst(roleitemPath, roleGo)

			MonoHelper.addNoUpdateLuaComOnceToGo(roleInstGo, DiceHeroRoleItem, {
				chapter = chapter
			})
		end
	end
end

return DiceHeroLevelView
