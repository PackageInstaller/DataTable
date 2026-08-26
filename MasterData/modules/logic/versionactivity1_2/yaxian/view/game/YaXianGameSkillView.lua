-- chunkname: @modules/logic/versionactivity1_2/yaxian/view/game/YaXianGameSkillView.lua

module("modules.logic.versionactivity1_2.yaxian.view.game.YaXianGameSkillView", package.seeall)

local YaXianGameSkillView = class("YaXianGameSkillView", BaseView)

function YaXianGameSkillView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function YaXianGameSkillView:addEvents()
	return
end

function YaXianGameSkillView:removeEvents()
	return
end

function YaXianGameSkillView:onClickSkillBtn()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_resources_rebound)
	self:changeSkillDescContainerVisible()
end

function YaXianGameSkillView:onBlockClick()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	self:changeSkillDescContainerVisible()
end

function YaXianGameSkillView:_editableInitView()
	self.goSkillBlock = gohelper.findChild(self.viewGO, "root/#go_skillblock")
	self.blockClick = gohelper.getClick(self.goSkillBlock)

	self.blockClick:AddClickListener(self.onBlockClick, self)

	self.goSkillContainer = gohelper.findChild(self.viewGO, "root/bottomleft")
	self.goSkillDescContent = gohelper.findChild(self.goSkillContainer, "skillDescContent")

	gohelper.setActive(self.goSkillDescContent, false)

	self.showSkillDescContainer = false
	self.goSkillDescItem1 = gohelper.findChild(self.goSkillContainer, "skillDescContent/#go_skillDescItem1")
	self.goSkillDescItem2 = gohelper.findChild(self.goSkillContainer, "skillDescContent/#go_skillDescItem2")
	self.goSkillItem1 = gohelper.findChild(self.goSkillContainer, "#go_simple/skillContent/skill1")
	self.goSkillItem2 = gohelper.findChild(self.goSkillContainer, "#go_simple/skillContent/skill2")
	self.skillBtn = gohelper.findChildClickWithAudio(self.goSkillContainer, "#go_simple/clickarea")

	self.skillBtn:AddClickListener(self.onClickSkillBtn, self)
	gohelper.setActive(self.goSkillDescContent, false)
	self.addEventCb(self, YaXianGameController.instance, YaXianEvent.OnUpdateSkillInfo, self.onUpdateSkillInfo, self)
end

function YaXianGameSkillView:initSkillDescItem(goContainer, skillId)
	local skillDescItem = self:getUserDataTb_()

	skillDescItem.goContainer = goContainer
	skillDescItem.txtDesc = gohelper.findChildText(goContainer, "desc")
	skillDescItem.goCantUse = gohelper.findChild(goContainer, "skill/cantuse")
	skillDescItem.goCanUse = gohelper.findChild(goContainer, "skill/canuse")
	skillDescItem.skillId = skillId
	skillDescItem.animator = gohelper.findChild(goContainer, "skill"):GetComponent(typeof(UnityEngine.Animator))
	skillDescItem.click = gohelper.getClick(goContainer)

	skillDescItem.click:AddClickListener(self.onClickSkillItem, self, skillDescItem)

	return skillDescItem
end

function YaXianGameSkillView:initSkillItem(goContainer, skillId)
	local skillItem = self:getUserDataTb_()

	skillItem.goContainer = goContainer
	skillItem.imgicon = gohelper.findChildImage(goContainer, "icon")
	skillItem.goCantUse = gohelper.findChild(goContainer, "cantuse")
	skillItem.goCanUse = gohelper.findChild(goContainer, "canuse")
	skillItem.skillId = skillId
	skillItem.animator = goContainer:GetComponent(typeof(UnityEngine.Animator))

	return skillItem
end

function YaXianGameSkillView:onClickSkillItem(skillDescItem)
	local skillMo = YaXianGameModel.instance:getSkillMo(skillDescItem.skillId)

	if not skillMo then
		return
	end

	if skillMo.canUseCount <= 0 then
		return
	end

	if skillMo.id == YaXianGameEnum.SkillId.InVisible then
		AudioMgr.instance:trigger(AudioEnum.YaXian.InVisible)
	end

	Activity115Rpc.instance:sendAct115UseSkillRequest(skillMo.actId, skillMo.id)
	self:changeSkillDescContainerVisible()
end

function YaXianGameSkillView:onUpdateParam()
	self:refreshUI()
end

function YaXianGameSkillView:onOpen()
	gohelper.setActive(self.goSkillBlock, false)

	self.hideSkillDescItem = self:initSkillDescItem(self.goSkillDescItem1, YaXianGameEnum.SkillId.InVisible)
	self.throughSkillDescItem = self:initSkillDescItem(self.goSkillDescItem2, YaXianGameEnum.SkillId.ThroughWall)
	self.hideSkillItem = self:initSkillItem(self.goSkillItem1, YaXianGameEnum.SkillId.InVisible)
	self.throughSkillItem = self:initSkillItem(self.goSkillItem2, YaXianGameEnum.SkillId.ThroughWall)
	self.hideSkillDescItem.txtDesc.text = YaXianConfig.instance:getSkillConfig(YaXianEnum.ActivityId, YaXianGameEnum.SkillId.InVisible).desc
	self.throughSkillDescItem.txtDesc.text = YaXianConfig.instance:getSkillConfig(YaXianEnum.ActivityId, YaXianGameEnum.SkillId.ThroughWall).desc

	local hadSkill = YaXianGameModel.instance:hasSkill()

	if hadSkill then
		AudioMgr.instance:trigger(AudioEnum.RewardPoint.play_ui_track_achievement_single)
	end

	self:refreshUI()
end

function YaXianGameSkillView:refreshUI()
	local hadSkill = YaXianGameModel.instance:hasSkill()

	gohelper.setActive(self.goSkillContainer, hadSkill)

	if not hadSkill then
		return
	end

	self:refreshSkillDescItem(self.hideSkillDescItem)
	self:refreshSkillDescItem(self.throughSkillDescItem)
	self:refreshSkillItem(self.hideSkillItem)
	self:refreshSkillItem(self.throughSkillItem)
end

function YaXianGameSkillView:refreshSkillDescItem(skillDescItem)
	local skillMo = YaXianGameModel.instance:getSkillMo(skillDescItem.skillId)

	if not skillMo then
		gohelper.setActive(skillDescItem.goContainer, false)

		return
	end

	gohelper.setActive(skillDescItem.goContainer, true)
	gohelper.setActive(skillDescItem.goCanUse, skillMo.canUseCount > 0)
	gohelper.setActive(skillDescItem.goCantUse, skillMo.canUseCount <= 0)
	self:playDescItemAnimator(skillDescItem)
end

function YaXianGameSkillView:playDescItemAnimator(skillDescItem)
	if self.showSkillDescContainer then
		local skillMo = YaXianGameModel.instance:getSkillMo(skillDescItem.skillId)

		if not skillMo then
			return
		end

		skillDescItem.animator:Play((skillMo.canUseCount > 0 or nil) and UIAnimationName.Open)
	end
end

YaXianGameSkillView.ModeSelectColor = Color.white
YaXianGameSkillView.ModeDisSelectColor = Color(0.4, 0.4, 0.4, 1)

function YaXianGameSkillView:refreshSkillItem(skillItem)
	local skillMo = YaXianGameModel.instance:getSkillMo(skillItem.skillId)

	if not skillMo then
		gohelper.setActive(skillItem.goContainer, false)

		return
	end

	gohelper.setActive(skillItem.goContainer, true)
	gohelper.setActive(skillItem.goCanUse, skillMo.canUseCount > 0)

	if skillMo.canUseCount > 0 then
		skillItem.imgicon.color = YaXianGameSkillView.ModeSelectColor or YaXianGameSkillView.ModeDisSelectColor
	end

	skillItem.animator:Play((skillMo.canUseCount > 0 or nil) and UIAnimationName.Open)
end

function YaXianGameSkillView:onUpdateSkillInfo()
	self:refreshUI()
end

function YaXianGameSkillView:changeSkillDescContainerVisible()
	self.showSkillDescContainer = not self.showSkillDescContainer

	gohelper.setActive(self.goSkillDescContent, self.showSkillDescContainer)
	gohelper.setActive(self.goSkillBlock, self.showSkillDescContainer)
	self:playDescItemAnimator(self.hideSkillDescItem)
	self:playDescItemAnimator(self.throughSkillDescItem)
end

function YaXianGameSkillView:onClose()
	return
end

function YaXianGameSkillView:onDestroyView()
	self.hideSkillDescItem.click:RemoveClickListener()
	self.throughSkillDescItem.click:RemoveClickListener()
	self.skillBtn:RemoveClickListener()
	self.blockClick:RemoveClickListener()
end

return YaXianGameSkillView
