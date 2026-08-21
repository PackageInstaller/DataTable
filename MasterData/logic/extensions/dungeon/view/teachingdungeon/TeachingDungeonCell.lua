-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/teachingdungeon/TeachingDungeonCell.lua

module("logic.extensions.dungeon.view.teachingdungeon.TeachingDungeonCell", package.seeall)

local M = class("TeachingDungeonCell", CellBaseComponent)
local ButtonAdapter = Astral.ButtonAdapter

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._trs = self._go.transform
end

function M:Awake()
	self:onInit()
end

function M:onInit()
	self._nameTxt = goutil.findChildTextComponent(self._go, "txtCaseName")
	self._descTxt = goutil.findChildComponent(self._go, "txtCaseDesc", UIComponentType.TextMeshProUGUI)
	self._lockGo = goutil.findChild(self._go, "unlock")
	self._rewardGo = goutil.findChild(self._go, "reward/cell/backpack_item")
	self._receivedGo = goutil.findChild(self._go, "reward/cell/stateReceived")
	self._canvasGroup = self._rewardGo:GetComponent(ComponentType.CanvasGroup)
	self._lockBtn = ButtonAdapter.Get(goutil.findChild(self._go, "unlock/btnClick"))

	self._lockBtn:AddClickListener(self._onClickLockBtn, self)

	self._fightBtn = ButtonAdapter.Get(goutil.findChild(self._go, "btnGo"))

	self._fightBtn:AddClickListener(self._onClickFightBtn, self)

	self._reviewBtn = ButtonAdapter.Get(goutil.findChild(self._go, "btnReview"))

	self._reviewBtn:AddClickListener(self._onClickFightBtn, self)

	self._rewardCell = Astral.LuaComponentContainer.Add(self._rewardGo, TeachingDungeonItemCell)
end

function M:setData(dungeonId)
	self._dungeonId = dungeonId

	self:_refreshCell()
end

function M:setClickFightCallBack(func, handle)
	self._clickFightCallFunc = func
	self._clickFightCallHandle = handle
end

function M:_refreshCell()
	self._dungeonMo = DungeonTeachingChapterModel.instance:getDungeonMoById(self._dungeonId)

	if self._dungeonMo:getIsUnlock() then
		goutil.setActive(self._lockGo, false)

		local teachingDungeonCO = self._dungeonMo:geteachingDungeonCO()

		self._nameTxt.text = self._dungeonMo:getName()
		self._descTxt.text = string.gsub(self._dungeonMo:getDesc(), "&", "")

		local rewardList = self._dungeonMo:getAllFirstPassReward()

		self:_updateReward(rewardList[1])
	else
		local teachingDungeonCO = self._dungeonMo:geteachingDungeonCO()

		self._nameTxt.text = StringUtil.randomReplaceToBlackBlock(self._dungeonMo:getName())
		self._descTxt.text = StringUtil.randomReplaceTMPToBlackBlock(self._dungeonMo:getDesc())

		local rewardList = self._dungeonMo:getAllFirstPassReward()

		self:_updateReward(rewardList[1])
		goutil.setActive(self._lockGo, true)
	end

	if self._dungeonMo:hasPassed() then
		goutil.setActive(self._fightBtn.gameObject, false)
		goutil.setActive(self._reviewBtn.gameObject, true)
		goutil.setActive(self._receivedGo, true)

		self._canvasGroup.alpha = 0.5
	else
		goutil.setActive(self._fightBtn.gameObject, true)
		goutil.setActive(self._reviewBtn.gameObject, false)
		goutil.setActive(self._receivedGo, false)

		self._canvasGroup.alpha = 1
	end
end

function M:_updateReward(reward)
	if reward then
		local itemData = ItemData.New({
			itemId = reward.code,
			count = reward.num
		})

		goutil.setActive(self._rewardGo, true)
		self._rewardCell:Awake()
		self._rewardCell:updateData(itemData)
		self._rewardCell:getComponent("reward"):setRewardStatus(self._dungeonMo:hasPassed() and CommEnum.RewardEnum.HasGot or CommEnum.RewardEnum.CanNotGot)
		self._rewardCell:setShowSelectedEffect(false)
	end
end

function M:OnDestroy()
	self._fightBtn:RemoveClickListener()
	self._reviewBtn:RemoveClickListener()
	self._lockBtn:RemoveClickListener()
end

function M:_onClickFightBtn()
	if self._clickFightCallFunc then
		self._clickFightCallFunc(self._clickFightCallHandle, self._dungeonId)
	end

	printWarn("_onClickFightBtn", self._dungeonId)
end

function M:_onClickLockBtn()
	FloatWordMgr.instance:show(lang("tip_teaching_lock"))
end

return M
