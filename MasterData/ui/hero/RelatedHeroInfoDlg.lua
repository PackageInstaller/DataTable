-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\RelatedHeroInfoDlg.lua

local ResInfoNotice = require("ClientData/ResInfoNotice")
local ResHero = require("ClientData/ResHero")
local strClassName = "RelatedHeroInfoDlg"
local RelatedHeroInfoDlg = Class(strClassName, UIControls.Window)

function RelatedHeroInfoDlg:ctor()
	self:initUI()
end

function RelatedHeroInfoDlg:initUI()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onCloseClick)

	self.gridHeroLeft = UIControls.RelatedHeroGridChild(self, "BgPanel/VanityHeroPanel/GridLeftPanel", "System/Hero/GridVanityHeroStarUp", 0, 0, true)

	self.gridHeroLeft.btnSensor:setEnable(false)

	self.gridHeroRight = UIControls.RelatedHeroGridChild(self, "BgPanel/VanityHeroPanel/GridRightPanel", "System/Hero/GridVanityHeroStarUp", 0, 0, true)

	self.gridHeroRight.btnSensor:setEnable(false)

	self.textRelatedDesc = UIControls.Label(self, "BgPanel/VanityHeroPanel/BgTextDes/TextDes")
	self.textDetailDesc = UIControls.Label(self, "BgPanel/VanityHeroDetailPanel/TextStoryList/Content/TextRule")
	self.panelHeroGet = UIControls.Panel(self, "BgPanel/VanityHeroGetPanel/VanityHeroGetPanel")
	self.textDialogDesc = UIControls.Label(self, "BgPanel/VanityHeroGetPanel/BgTextChat/TextChat")
	self.imgRole = UIControls.Role(self, "BgPanel/VanityHeroGetPanel/BgHeroPanel/ImgHeroPanel", 0, 0)
	self.imgStar = UIControls.Image(self, "BgPanel/VanityHeroGetPanel/VanityHeroGetPanel/BgMaxStar/ImgStar")
	self.btnJump = UIControls.Button(self, "BgPanel/VanityHeroGetPanel/VanityHeroGetPanel/BtnGet", "Text")

	self.btnJump:addEventClick(self.onJumpClick)
end

function RelatedHeroInfoDlg:showHero(heroId, hideJump)
	self.relateData = Const.UNIQUE_HERO[heroId]

	if not self.relateData then
		return
	end

	if hideJump then
		self.panelHeroGet:setVisible(false)
	end

	self.textRelatedDesc:setText(self.relateData.related_desc or "")
	self.textDialogDesc:setText(self.relateData.dialog_desc)
	self.textDetailDesc:setText(ResInfoNotice[Const.INFO_NOTICE_RELATED_HERO].content)

	if self.relateData.role_id then
		self.imgRole:showRole(self.relateData.role_id)
	end

	self.gridHeroLeft:setHero(heroId)
	self.gridHeroRight:setHero(self.relateData.resid)

	local star = CurAvatar:getHeroMaxStar(heroId)
	local starPath = UIConst.getHeroStarPath(star, true)

	if starPath then
		self.imgStar:setImage(starPath[1], starPath[2])
	end

	if not self.gridHeroRight.hasHero then
		self.btnJump:setText(Lang.get(53136))
	else
		local heroData = ResHero[self.relateData.resid]

		if heroData.star_limit and star >= heroData.star_limit then
			self.btnJump:setVisible(false)
		else
			self.btnJump:setText(Lang.get(55405))
		end
	end
end

function RelatedHeroInfoDlg:onCloseClick()
	self:setVisible(false)
end

function RelatedHeroInfoDlg:onJumpClick()
	if self.gridHeroRight.hasHero then
		if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_HERO_STARUP) then
			MsgManager.notice(ConditionLimitManager.getLimitUnlockDesc(Const.CONDITION_LIMIT_HERO_STARUP))
		else
			self:setVisible(false)

			local relatedHero = CurAvatar:getHeroMaxStarHero(self.relateData.resid)

			if relatedHero then
				local starUpDlg = UIManager.getUI("heroStarUpDlg", true)

				starUpDlg:setHeroToExchagngePanel(relatedHero)
			end
		end
	else
		if self.relateData.act_id then
			local actObj = CurAvatar:getActivityObj(self.relateData.act_id)

			if actObj and actObj:isValid() then
				self:setVisible(false)
				CurAvatar:jumpToShowActivity(self.relateData.act_id)

				return
			end
		end

		if self.relateData.jump_id then
			JumpGuideManager.jump(self.relateData.jump_id, self.mUIName)
		end
	end
end

return RelatedHeroInfoDlg
