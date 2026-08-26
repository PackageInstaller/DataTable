-- chunkname: @modules/logic/versionactivity3_7/anniversary3/view/Anniversary3SignRoleTalkView.lua

module("modules.logic.versionactivity3_7.anniversary3.view.Anniversary3SignRoleTalkView", package.seeall)

local Anniversary3SignRoleTalkView = class("Anniversary3SignRoleTalkView", BaseView)

function Anniversary3SignRoleTalkView:onInitView()
	self._btnclosebtn = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_closebtn")
	self._txtrolename = gohelper.findChildText(self.viewGO, "root/#txt_rolename")
	self._txttalk = gohelper.findChildText(self.viewGO, "root/#txt_talk")
	self._gorewardlist = gohelper.findChild(self.viewGO, "root/#go_rewardlist")
	self._gorewardlistitem = gohelper.findChild(self.viewGO, "root/#go_rewardlist/#go_reward_item")
	self._simagerole = gohelper.findChildSingleImage(self.viewGO, "root/imagerole_mask/#simage_role")
	self._simagerolename = gohelper.findChildSingleImage(self.viewGO, "root/#simage_signature")
	self._imagerole = gohelper.findChildImage(self.viewGO, "root/imagerole_mask/#simage_role")
	self._imagerolename = gohelper.findChildImage(self.viewGO, "root/#simage_signature")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Anniversary3SignRoleTalkView:addEvents()
	self._btnclosebtn:AddClickListener(self.closeThis, self)
end

function Anniversary3SignRoleTalkView:removeEvents()
	self._btnclosebtn:RemoveClickListener()
end

function Anniversary3SignRoleTalkView:_btnclosebtnOnClick()
	self:closeThis()
end

function Anniversary3SignRoleTalkView:_editableInitView()
	return
end

function Anniversary3SignRoleTalkView:onUpdateParam()
	return
end

function Anniversary3SignRoleTalkView:onOpen()
	self._rewardList = {}
	self._actId = self.viewParam.actId or VersionActivity3_7Enum.ActivityId.Anniversary3Sign
	self._config = Anniversary3Config.instance:getSignInCo(self.viewParam.day, self._actId)

	self:_refresh()
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_day_night)
end

function Anniversary3SignRoleTalkView:_refresh()
	self:_refreshUI()
	self:_refreshRewardList()
end

function Anniversary3SignRoleTalkView:_refreshUI()
	if self._config then
		local heroId = self._config.characterId
		local skinId = self._config.skinid

		if skinId == 0 and heroId then
			local heroCo = HeroConfig.instance:getHeroCO(heroId)

			skinId = heroCo and heroCo.skinId
		end

		if skinId then
			self._simagerole:LoadImage(ResUrl.getHeadIconImg(skinId), self._onRoleImageLoaded, self)
		end

		self._simagerolename:LoadImage(ResUrl.getSignature(self._config.signature, "characterget"), self._onRoleNameLoaded, self)

		if not LuaUtil.isEmptyStr(self._config.skinlocation) then
			local pos = string.splitToNumber(self._config.skinlocation, "#")

			transformhelper.setLocalPos(self._simagerole.gameObject.transform, pos[1], pos[2], 0)
		end

		self._txtrolename.text = self._config.name
		self._txttalk.text = self._config.content
	end
end

function Anniversary3SignRoleTalkView:_onRoleImageLoaded()
	self._imagerole:SetNativeSize()
end

function Anniversary3SignRoleTalkView:_onRoleNameLoaded()
	self._imagerolename:SetNativeSize()
end

function Anniversary3SignRoleTalkView:_refreshRewardList()
	local config = ActivityConfig.instance:getNorSignActivityCo(self._actId, self.viewParam.day)
	local bonusCo = GameUtil.splitString2(config.bonus, true)

	for i = 1, #bonusCo do
		if not self._rewardList[i] then
			self._rewardList[i] = self:getUserDataTb_()
			self._rewardList[i].go = gohelper.clone(self._gorewardlistitem, self._gorewardlist, "item" .. i)
			self._rewardList[i].goIcon = gohelper.findChild(self._rewardList[i].go, "#go_item")
			self._rewardList[i].gohasget = gohelper.findChild(self._rewardList[i].go, "go_hasget")
			self._rewardList[i].animGet = self._rewardList[i].gohasget:GetComponent(typeof(UnityEngine.Animator))
			self._rewardList[i].itemIcon = IconMgr.instance:getCommonPropItemIcon(self._rewardList[i].goIcon)
		end

		gohelper.setActive(self._rewardList[i].gohasget, true)
		self._rewardList[i].itemIcon:setMOValue(bonusCo[i][1], bonusCo[i][2], bonusCo[i][3], nil, true)
		gohelper.setActive(self._rewardList[i].go, true)
	end
end

function Anniversary3SignRoleTalkView:onClose()
	return
end

function Anniversary3SignRoleTalkView:onDestroyView()
	return
end

return Anniversary3SignRoleTalkView
