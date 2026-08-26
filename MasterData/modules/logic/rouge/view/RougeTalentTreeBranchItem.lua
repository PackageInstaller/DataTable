-- chunkname: @modules/logic/rouge/view/RougeTalentTreeBranchItem.lua

module("modules.logic.rouge.view.RougeTalentTreeBranchItem", package.seeall)

local RougeTalentTreeBranchItem = class("RougeTalentTreeBranchItem", LuaCompBase)

function RougeTalentTreeBranchItem:init(go)
	self:__onInit()

	self.viewGO = go
end

function RougeTalentTreeBranchItem:initcomp(config, parentIndex)
	self._config = config
	self._id = config.id
	self.isOrigin = self._config.isOrigin == 1
	self._parentIndex = parentIndex
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")
	self._goselectframe = gohelper.findChild(self.viewGO, "#go_selectframe")
	self._imagetalenicon = gohelper.findChildImage(self.viewGO, "#image_talenicon")
	self._gotalentname = gohelper.findChild(self.viewGO, "talenname")
	self._txtprogress = gohelper.findChildText(self.viewGO, "#txt_progress")
	self._golocked = gohelper.findChild(self.viewGO, "#go_locked")
	self._goprogressunfull = gohelper.findChild(self.viewGO, "#go_progress_unfull")
	self._goprogressunfullLight = gohelper.findChild(self.viewGO, "#go_progress_unfull/small_light")
	self._imgprogress = gohelper.findChildImage(self.viewGO, "#go_progress_unfull/circle")
	self._goprogressfull = gohelper.findChild(self.viewGO, "#go_progress_full")
	self._goup = gohelper.findChild(self.viewGO, "#go_up")
	self._golight = gohelper.findChild(self.viewGO, "#go_light")

	gohelper.setActive(self._golight, false)

	self._gocanselect = gohelper.findChild(self.viewGO, "#go_canselect")
	self._selectGO = gohelper.findChild(self.viewGO, "#go_select")

	gohelper.setActive(self._selectGO, true)

	self._selectGOs = {}

	for i = 1, 3 do
		self._selectGOs[i] = gohelper.findChild(self.viewGO, "#go_select/" .. i)
	end

	self._showAnim = false

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeTalentTreeBranchItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function RougeTalentTreeBranchItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function RougeTalentTreeBranchItem:_btnclickOnClick()
	RougeController.instance:dispatchEvent(RougeEvent.OnClickTreeNode, self._config)
	AudioMgr.instance:trigger(AudioEnum.UI.SelcetTalentItem)
end

function RougeTalentTreeBranchItem:_editableInitView()
	self:addEvents()
end

function RougeTalentTreeBranchItem:refreshItem(isSelect, talentid)
	local cost = self._config.cost
	local isSmall = cost == 1
	local hadUnlock = RougeTalentModel.instance:getUnlockNumByTalent(self._parentIndex)
	local allNum = RougeTalentConfig.instance:getBranchNumByTalent(self._parentIndex)
	local rate = hadUnlock / allNum
	local isfull = rate >= 1

	self._imgprogress.fillAmount = rate

	gohelper.setActive(self._goprogressunfull, not isfull and self.isOrigin)
	gohelper.setActive(self._goprogressfull, isfull and self.isOrigin)

	local canup = RougeTalentModel.instance:checkNodeCanLevelUp(self._config)

	gohelper.setActive(self._gocanselect, canup)

	if isSmall then
		transformhelper.setLocalScale(self._golight.transform, 0.5, 0.5, 1)
	else
		transformhelper.setLocalScale(self._golight.transform, 0.8, 0.8, 1)
	end

	if talentid and talentid == self._config.id then
		gohelper.setActive(self._golight, true)
		AudioMgr.instance:trigger(AudioEnum.UI.LightTalentItem)
	else
		gohelper.setActive(self._golight, false)
	end

	local lock = RougeTalentModel.instance:checkNodeLock(self._config)

	if canup and not self.isOrigin then
		if isSmall then
			transformhelper.setLocalScale(self._gocanselect.transform, 0.5, 0.5, 1)
		else
			transformhelper.setLocalScale(self._gocanselect.transform, 0.8, 0.8, 1)
		end
	end

	gohelper.setActive(self._gotalentname, false)
	gohelper.setActive(self._txtprogress.gameObject, false)
	gohelper.setActive(self._golocked, false)

	if not string.nilorempty(self._config.icon) then
		if RougeTalentModel.instance:checkNodeLight(self._config.id) then
			UISpriteSetMgr.instance:setRougeSprite(self._imagetalenicon, self._config.icon)
		else
			UISpriteSetMgr.instance:setRougeSprite(self._imagetalenicon, self._config.icon .. "_locked")
		end
	end

	gohelper.setActive(self._goprogress, self.isOrigin)

	local isopen = not lock and not isfull
	local hadUp = RougeTalentModel.instance:getUnlockNumByTalent(self._parentIndex) > 0

	gohelper.setActive(self._goprogressunfullLight, isopen and hadUp and self.isOrigin)

	if isSelect then
		gohelper.setActive(self._selectGOs[self.isOrigin and 3 or isSmall and 1 or 2], true)
	else
		for _, go in ipairs(self._selectGOs) do
			gohelper.setActive(go, false)
		end
	end
end

function RougeTalentTreeBranchItem:getID()
	return self._id
end

function RougeTalentTreeBranchItem:onDestroy()
	return
end

function RougeTalentTreeBranchItem:dispose()
	self:removeEvents()
	self:__onDispose()
end

return RougeTalentTreeBranchItem
