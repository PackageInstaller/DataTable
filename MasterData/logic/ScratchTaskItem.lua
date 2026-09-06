-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scratch/view/ScratchTaskItem.lua

module("logic.extensions.scratch.view.ScratchTaskItem", package.seeall)

local ScratchTaskItem = class("ScratchTaskItem")

function ScratchTaskItem:ctor(luaComponentContainer)
	local go = luaComponentContainer.gameObject

	self._txtTitle = goutil.findChildTextComponent(go, "txtTitle")
	self._txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	self._txtProgress = goutil.findChildTextComponent(go, "txtProgress")
	self._txtReward = goutil.findChildTextComponent(go, "txtReward")
	self._btnGo = Framework.ButtonAdapter.GetFrom(go, "btnGo")
	self._finish = goutil.findChild(go, "finish")
end

function ScratchTaskItem:init(index, data)
	self._data = data

	self._btnGo:AddClickListener(self._onBtnClick, self)

	if data.isPayScore then
		self._txtReward.gameObject:SetActive(false)

		local cfg = ScratchConfig.instance:getScratchParamsCfg("PAY_PRIZE_SCORE")

		self._txtTitle.text = "充值"
		self._txtDesc.text = string.format("每充值%s元可获得1积分", cfg.value)
		self._txtProgress.text = string.format("已累计获得：%d积分", data.payScore)

		self._btnGo.gameObject:SetActive(true)
		self._finish:SetActive(false)
	else
		self._txtReward.gameObject:SetActive(true)

		local cfg = ScratchConfig.instance:getScratchTaskCfg(data.taskId)

		self._cfg = cfg

		if cfg then
			self._txtTitle.text = cfg.title
			self._txtDesc.text = cfg.desc
			self._txtProgress.text = data.curProgress .. "/" .. cfg.maxProgress
			self._txtReward.text = cfg.score .. "积分"
		else
			printInfo("test 配置不存在", data.taskId)
		end

		self._btnGo.gameObject:SetActive(not data.hasFinished)
		self._finish:SetActive(data.hasFinished)
	end
end

function ScratchTaskItem:reset()
	self._btnGo:RemoveClickListener()
end

function ScratchTaskItem:_onBtnClick()
	if self._data.isPayScore then
		UIStateManager.instance:popByName(ViewName.ScratchTaskView)
		UIStateManager.instance:push(ViewName.PayShopMainView)
	elseif self._cfg then
		UIStateManager.instance:popByName(ViewName.ScratchTaskView)
		GotoMgr.gotoByString(self._cfg.jumpTo)
	end
end

return ScratchTaskItem
