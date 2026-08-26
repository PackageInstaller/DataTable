-- chunkname: @modules/logic/rouge/dlc/101/view/RougeFactionLockedTips.lua

module("modules.logic.rouge.dlc.101.view.RougeFactionLockedTips", package.seeall)

local RougeFactionLockedTips = class("RougeFactionLockedTips", BaseView)

function RougeFactionLockedTips:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._scrolltips = gohelper.findChildScrollRect(self.viewGO, "#scroll_tips")
	self._imageskillicon = gohelper.findChildImage(self.viewGO, "#scroll_tips/Viewport/Content/top/#image_skillicon")
	self._godesccontainer = gohelper.findChild(self.viewGO, "#scroll_tips/Viewport/Content/#go_desccontainer")
	self._txtdecitem = gohelper.findChildText(self.viewGO, "#scroll_tips/Viewport/Content/#go_desccontainer/#txt_decitem")
	self._btncostunlock = gohelper.findChildButtonWithAudio(self.viewGO, "#scroll_tips/Viewport/Content/#btn_costunlock")
	self._txtunlocknum = gohelper.findChildText(self.viewGO, "#scroll_tips/Viewport/Content/#btn_costunlock/#txt_unlocknum")
	self._imageicon = gohelper.findChildImage(self.viewGO, "#scroll_tips/Viewport/Content/#btn_costunlock/#txt_unlocknum/#image_icon")
	self._goRightTop = gohelper.findChild(self.viewGO, "#go_RightTop")
	self._imagepoint = gohelper.findChildImage(self.viewGO, "#go_RightTop/point/#image_point")
	self._txtpoint = gohelper.findChildText(self.viewGO, "#go_RightTop/point/#txt_point")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#go_RightTop/point/#btn_click")
	self._gotips = gohelper.findChild(self.viewGO, "#go_RightTop/tips")
	self._txttips = gohelper.findChildText(self.viewGO, "#go_RightTop/tips/#txt_tips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeFactionLockedTips:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btncostunlock:AddClickListener(self._btncostunlockOnClick, self)
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function RougeFactionLockedTips:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btncostunlock:RemoveClickListener()
	self._btnclick:RemoveClickListener()
end

function RougeFactionLockedTips:_btncloseOnClick()
	self:closeThis()
end

function RougeFactionLockedTips:_btncostunlockOnClick()
	local curTotalEmblem = RougeDLCModel101.instance:getTotalEmblemCount()

	if curTotalEmblem >= self._unlockEmblem then
		AudioMgr.instance:trigger(AudioEnum.UI.UnlockRougeSkill)

		local season = RougeOutsideModel.instance:season()

		RougeRpc.instance:sendRougeUnlockSkillRequest(season, self._unlockSkillId, function(_, resultCode)
			if resultCode ~= 0 then
				return
			end

			local gameRecordInfo = RougeOutsideModel.instance:getRougeGameRecord()

			gameRecordInfo:updateSkillUnlockInfo(self._skillType, self._unlockSkillId)

			local limiterMo = RougeDLCModel101.instance:getLimiterMo()

			limiterMo:updateTotalEmblemCount(-self._unlockEmblem)
			RougeDLCController101.instance:dispatchEvent(RougeDLCEvent101.UpdateEmblem)
			RougeController.instance:dispatchEvent(RougeEvent.UpdateUnlockSkill, self._skillType, self._unlockSkillId)
			self:closeThis()
		end)
	else
		GameFacade.showToast(ToastEnum.LackEmblem)
	end
end

function RougeFactionLockedTips:_btnclickOnClick()
	self._isTipVisible = not self._isTipVisible

	gohelper.setActive(self._gotips, self._isTipVisible)
end

function RougeFactionLockedTips:_editableInitView()
	self.addEventCb(self, RougeDLCController101.instance, RougeDLCEvent101.UpdateEmblem, self._onUpdateEmblem, self)
end

function RougeFactionLockedTips:onUpdateParam()
	return
end

function RougeFactionLockedTips:onOpen()
	self:_refreshSkillInfo()
	self:_onUpdateEmblem()
end

local MatchEmblemColor = "#D5D1C8"
local LackEmblemColor = "#BF2E11"

function RougeFactionLockedTips:_refreshSkillInfo()
	self._unlockSkillId = self.viewParam and self.viewParam.skillId

	local unlockCo = RougeDLCConfig101.instance:getUnlockSkills(self._unlockSkillId)

	self._skillType = unlockCo.type

	if unlockCo then
		self._unlockEmblem = unlockCo.unlockEmblem or 0
	end

	local totalEmblemCount = RougeDLCModel101.instance:getTotalEmblemCount()
	local isEmblemCountMatch = totalEmblemCount >= self._unlockEmblem

	if isEmblemCountMatch then
		if not MatchEmblemColor then
			local emblemCountColor = LackEmblemColor

			self._txtunlocknum.text = string.format("<%s>-%s</color>", emblemCountColor, self._unlockEmblem)

			local rougeConfig = RougeOutsideModel.instance:config()
			local skillCo = rougeConfig:getSkillCo(unlockCo.type, unlockCo.skillId)

			gohelper.CreateObjList(self, self.refreshDesc, (not string.nilorempty(skillCo.desc) or nil) and string.split(skillCo.desc, "#"), self._godesccontainer, self._txtdecitem.gameObject)
			UISpriteSetMgr.instance:setRouge2Sprite(self._imageskillicon, skillCo.icon)
		end
	end
end

function RougeFactionLockedTips:refreshDesc(obj, descStr, index)
	local txtDesc = gohelper.onceAddComponent(obj, gohelper.Type_TextMesh)

	txtDesc.text = descStr
end

function RougeFactionLockedTips:_onUpdateEmblem()
	local maxEmbleCountCo = lua_rouge_dlc_const.configDict[RougeDLCEnum101.Const.MaxEmblemCount]

	if maxEmbleCountCo then
		if not maxEmbleCountCo.value then
			local maxEmblemCount = 0
			local curTotalEmblem = RougeDLCModel101.instance:getTotalEmblemCount()
			local params = {
				curTotalEmblem,
				maxEmblemCount
			}

			self._txtpoint.text = RougeDLCModel101.instance:getTotalEmblemCount()
			self._txttips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("rouge_dlc_101_emblemTips"), params)
		end
	end
end

function RougeFactionLockedTips:onClose()
	return
end

function RougeFactionLockedTips:onDestroyView()
	return
end

return RougeFactionLockedTips
