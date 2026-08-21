-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/achievement/AchievementSkillItem.lua

module("logic.extensions.playerinfo.view.achievement.AchievementSkillItem", package.seeall)

local M = class("AchievementSkillItem", ListBinderCell)

function M:ctor(compContainer)
	M.super.ctor(self, compContainer)

	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject

	self:_buildUI()
end

function M:_buildUI()
	self._txtDesc = goutil.findChildTextComponent(self._mainGo, "txtDesc")
	self._txtNum = goutil.findChildTextComponent(self._mainGo, "txtProgress")
	self._imgFill = goutil.findChildImageComponent(self._mainGo, "Image1/fill")
	self._rewardRootTrs = goutil.findChild(self._mainGo, "cell").transform
	self._btnGet = Astral.ButtonAdapter.Get(goutil.findChild(self._mainGo, "btnGet"))
	self._btnJump = Astral.ButtonAdapter.Get(goutil.findChild(self._mainGo, "btnJump"))
	self._ani = goutil.addComponentOnce(self._mainGo, ComponentType.Animation)
	self._canvasGroup = self._mainGo:GetComponent(ComponentType.CanvasGroup)

	self:_bindEvents()
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:_bindEvents()
	self._btnGet:AddClickListener(self._onClickBtnGet, self)
	self._btnJump:AddClickListener(self._onClicBtnJump, self)
end

function M:_unbindEvents()
	self._btnGet:RemoveClickListener()
	self._btnJump:RemoveClickListener()
end

function M:playAni()
	self._mainGo:GetComponent(ComponentType.CanvasGroup).alpha = 1

	self._ani:Stop()
	self._ani:Play("achievement_panel_example_open")
end

function M:_onClickBtnGet()
	AchievementAgent.instance:sendTakeRewardRequest({
		self._data:getId()
	})
end

function M:_onClicBtnJump()
	ViewMgr.instance:close(ViewName.PlayerInfoMain)

	local jumpId = self._data:getJumpId()

	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_EVENT, jumpId)
end

function M:updateData(data)
	self._data = data
	self._txtDesc.text = self._data:getDesc()
	self._txtNum.text = string.format("（%s/%s）", self._data:getFinishCnt(), self._data:getMaxCnt())
	self._imgFill.fillAmount = self._data:getFinishCnt() / self._data:getMaxCnt()

	local rewardList = self._data:getRewardList()

	if #rewardList > 0 then
		while self._rewardRootTrs.childCount < #rewardList do
			local itemGo = goutil.cloneAndSetParent(self._rewardRootTrs:GetChild(0).gameObject, self._rewardRootTrs)

			itemGo.transform:SetSiblingIndex(0)
		end

		for i = 0, self._rewardRootTrs.childCount - 1 do
			local go = self._rewardRootTrs:GetChild(i).gameObject
			local hasData = i + 1 <= #rewardList
			local rewardItem = Astral.LuaComponentContainer.Add(go, ItemCell)

			rewardItem:setShowSelectedEffect(false)

			if hasData then
				rewardItem:updateData(ItemData.New({
					count = rewardList[i + 1].num,
					itemId = rewardList[i + 1].itemId
				}))
			end

			goutil.setActive(go, hasData)
		end
	end

	self._btnGet.gameObject:SetActive(false)
	self._btnJump.gameObject:SetActive(false)

	self._canvasGroup.alpha = 1

	if self._data:getIsFinish() then
		self._canvasGroup.alpha = 0.5
	elseif self._data:canGetReward() then
		self._btnGet.gameObject:SetActive(true)
	elseif self._data:canJump() then
		self._btnJump.gameObject:SetActive(true)
	end
end

function M:OnDestroy()
	self:_destroyUI()
end

function M:_destroyUI()
	self:_unbindEvents()
end

return M
