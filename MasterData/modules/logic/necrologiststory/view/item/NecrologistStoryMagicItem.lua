-- chunkname: @modules/logic/necrologiststory/view/item/NecrologistStoryMagicItem.lua

module("modules.logic.necrologiststory.view.item.NecrologistStoryMagicItem", package.seeall)

local NecrologistStoryMagicItem = class("NecrologistStoryMagicItem", NecrologistStoryControlItem)

function NecrologistStoryMagicItem:onInit()
	self.anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self.bg = gohelper.findChild(self.viewGO, "root/image")
	self.goMagic = gohelper.findChild(self.viewGO, "root/#btn_zhouyu/magic")
	self.btnMagic = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_zhouyu")
	self.goReddot = gohelper.findChild(self.viewGO, "root/#btn_zhouyu/#reddot")

	self:initSkillIcon()

	self.txtTime = gohelper.findChildTextMesh(self.viewGO, "root/#btn_zhouyu/#txt_time")
	self.goProgress = gohelper.findChild(self.viewGO, "root/#go_progress")
	self.imgFill = gohelper.findChildImage(self.goProgress, "fill")
end

function NecrologistStoryMagicItem:onAddEvent()
	self.addClickCb(self, self.btnMagic, self.onClickMagic, self)
end

function NecrologistStoryMagicItem:onRemoveEvent()
	self:removeClickCb(self.btnMagic)
end

function NecrologistStoryMagicItem:onClickMagic()
	if self.isClicked then
		return
	end

	self.anim:Play("click", 0, 0)

	local param = string.split(self._controlParam, "#")
	local type = tonumber(param[2])

	if type == 1 then
		local introduceId = tonumber(param[3])

		NecrologistStoryController.instance:openTipView(introduceId)
	elseif type == 2 then
		local picName = param[3]

		NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.OnChangePic, picName)
	end

	self.isClicked = true

	if self.leftTime and self.leftTime > 0 and self._tweenId then
		local mo = NecrologistStoryModel.instance:getCurStoryMO()

		if mo then
			mo:markSpecial(self._storyId)
		end

		self.txtTime.text = ""

		gohelper.setActive(self.goProgress, false)
		self:killTweenId()
	end

	self:setSkillIcon(false)
	self:onPlayFinish()
end

function NecrologistStoryMagicItem:onPlayStory(isSkip)
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_qiutu_award_all)

	self.isClicked = false

	local param = string.split(self._controlParam, "#")

	self.leftTime = param[5] and tonumber(param[5]) or 0
	self.skillIndex = param[6] and tonumber(param[6]) or 1

	self:loadMagic(param)
	self:setSkillIcon(true)
	self:startCountDown()
	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.StartMagic)
end

function NecrologistStoryMagicItem:loadMagic(param)
	local prefabRes = string.format("ui/viewres/dungeon/rolestory/magic/%s.prefab", param[1])

	self.magicLoader = PrefabInstantiate.Create(self.goMagic)

	self.magicLoader:startLoad(prefabRes, self.onMagicLoaded, self)
end

function NecrologistStoryMagicItem:startCountDown()
	self:killTweenId()

	local hasCountDown = self.leftTime > 0

	gohelper.setActive(self.goProgress, hasCountDown)

	if self.leftTime <= 0 then
		self.txtTime.text = ""

		return
	end

	self._tweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, self.leftTime, self._onFadeInUpdate, self._onFadeInFinish, self, nil, EaseType.Linear)
end

function NecrologistStoryMagicItem:_onFadeInUpdate(value)
	self.txtTime.text = string.format("%ss", math.ceil(value * self.leftTime))
	self.imgFill.fillAmount = value
end

function NecrologistStoryMagicItem:_onFadeInFinish()
	self.txtTime.text = ""

	gohelper.setActive(self.goProgress, false)
	self:killTweenId()
	self:onClickMagic()

	if not GuideController.instance:isForbidGuides() and not GuideModel.instance:isGuideFinish(GuideEnum.GuideId.NecrologistStoryMagic) then
		GuideViewMgr.instance:onClickCallback(true)
	end
end

function NecrologistStoryMagicItem:killTweenId()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function NecrologistStoryMagicItem:onMagicLoaded(loader)
	self.goMaicInst = loader:getInstGO()

	local goImage = gohelper.findChild(self.goMaicInst, "simageMagic")
	local width = recthelper.getWidth(goImage.transform)

	recthelper.setWidth(self.bg.transform, width + 140)
end

function NecrologistStoryMagicItem:initSkillIcon()
	self.skilIconDict = {}

	local goSkillRoot = gohelper.findChild(self.viewGO, "root/#btn_zhouyu/skillicon")
	local rootTransform = goSkillRoot.transform
	local childCount = rootTransform.childCount

	for i = 1, childCount do
		local child = rootTransform:GetChild(i - 1)
		local childGO = child.gameObject

		gohelper.setActive(childGO, false)

		local name = child.name
		local splitNames = string.split(name, "_")
		local childVersionId = tonumber(splitNames[1])

		if childVersionId then
			self.skilIconDict[childVersionId] = self.skilIconDict[childVersionId] or {}
			self.skilIconDict[childVersionId][(splitNames and tabletool.len(splitNames) > 1 or nil) and tonumber(splitNames[2])] = self:createSkillItem(childGO, childVersionId)
		end
	end
end

function NecrologistStoryMagicItem:createSkillItem(go, versionId)
	local item = self:getUserDataTb_()

	item.go = go
	item.versionId = versionId
	item.goAble = gohelper.findChild(item.go, "able")
	item.goUnable = gohelper.findChild(item.go, "unable")

	return item
end

function NecrologistStoryMagicItem:setSkillIcon(isAble)
	local versionId = NecrologistStoryHelper.getPlotRoleStoryId(self._storyId)
	local item = self.skilIconDict[versionId][self.skillIndex]

	if item then
		gohelper.setActive(item.go, true)
		gohelper.setActive(item.goAble, isAble)
		gohelper.setActive(item.goUnable, not isAble)
		gohelper.setActive(self.goReddot, isAble)
	else
		gohelper.setActive(self.goReddot, false)
	end
end

function NecrologistStoryMagicItem:caleHeight()
	return 100
end

function NecrologistStoryMagicItem:isDone()
	return self.isClicked
end

function NecrologistStoryMagicItem:onDestroy()
	self:killTweenId()
end

function NecrologistStoryMagicItem.getResPath()
	return "ui/viewres/dungeon/rolestory/item/necrologiststorymagicitem.prefab"
end

return NecrologistStoryMagicItem
