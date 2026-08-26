-- chunkname: @modules/logic/rouge/view/RougeTalentTreeItem.lua

module("modules.logic.rouge.view.RougeTalentTreeItem", package.seeall)

local RougeTalentTreeItem = class("RougeTalentTreeItem", LuaCompBase)

function RougeTalentTreeItem:initcomp(go, config, index)
	self._go = go
	self._config = config
	self._index = index
	self._btnclick = gohelper.findChildButtonWithAudio(self._go, "#btn_click")
	self._goselectframe = gohelper.findChild(self._go, "#go_selectframe")
	self._imagetalenicon = gohelper.findChildImage(self._go, "#image_talenicon")
	self._gotalenname = gohelper.findChild(self._go, "talenname")
	self._txttalenname = gohelper.findChildText(self._go, "talenname/#txt_talenname")
	self._txtprogress = gohelper.findChildText(self._go, "#txt_progress")
	self._golocked = gohelper.findChild(self._go, "#go_locked")
	self._goprogressunfull = gohelper.findChild(self._go, "#go_progress_unfull")
	self._goprogressunfullLight = gohelper.findChild(self._go, "#go_progress_unfull/small_light")
	self._imgprogress = gohelper.findChildImage(self._go, "#go_progress_unfull/circle")
	self._goprogressfull = gohelper.findChild(self._go, "#go_progress_full")
	self._golocked = gohelper.findChild(self._go, "#go_locked")
	self._animlock = self._golocked:GetComponent(typeof(UnityEngine.Animator))
	self._goup = gohelper.findChild(self._go, "#go_up")
	self._selectGO = gohelper.findChild(self._go, "#go_select")

	gohelper.setActive(self._selectGO, false)

	self._beforestatus = nil
	self._backViewOpenTime = 0.2

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeTalentTreeItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self.addEventCb(self, RougeController.instance, RougeEvent.reallyExitTalentView, self._onBackView, self)
end

function RougeTalentTreeItem:removeEvents()
	self._btnclick:RemoveClickListener()
	self.addEventCb(self, RougeController.instance, RougeEvent.reallyExitTalentView, self._onBackView, self)
end

function RougeTalentTreeItem:_btnclickOnClick()
	RougeController.instance:dispatchEvent(RougeEvent.enterTalentView, self._index)
end

function RougeTalentTreeItem:_editableInitView()
	self:addEvents()
end

function RougeTalentTreeItem:refreshItem()
	local lock = RougeTalentModel.instance:checkBigNodeLock(self._index)

	if not lock then
		self._animlock:Update(0)
		self._animlock:Play("idle", 0, 0)
		gohelper.setActive(self._golocked, lock)
	end

	self._beforestatus = self._beforestatus or lock

	local needUnlockList = RougeTalentModel.instance:getNextNeedUnlockTalent()
	local isNextUnlock = false
	local istargetid = false

	if needUnlockList then
		for _, id in pairs(needUnlockList) do
			if id == self._index then
				istargetid = true

				break
			end
		end
	end

	isNextUnlock = lock and istargetid

	gohelper.setActive(self._gotalenname, not lock or isNextUnlock)
	gohelper.setActive(self._txtprogress.gameObject, isNextUnlock)

	local canup = RougeTalentModel.instance:checkBigNodeShowUp(self._index)

	gohelper.setActive(self._goup, canup)

	local hadUnlock = RougeTalentModel.instance:getUnlockNumByTalent(self._index)
	local allNum = RougeTalentConfig.instance:getBranchNumByTalent(self._index)
	local rate = hadUnlock / allNum
	local isfull = rate >= 1

	self._imgprogress.fillAmount = rate

	if not string.nilorempty(self._config.icon) then
		if lock then
			UISpriteSetMgr.instance:setRougeSprite(self._imagetalenicon, self._config.icon .. "_locked")
		elseif hadUnlock > 0 then
			UISpriteSetMgr.instance:setRougeSprite(self._imagetalenicon, self._config.icon)
		else
			UISpriteSetMgr.instance:setRougeSprite(self._imagetalenicon, self._config.icon .. "_locked")
		end
	end

	local season = RougeOutsideModel.instance:season()
	local config = RougeTalentConfig.instance:getConfigByTalent(season, self._index)
	local allUnlockNum = RougeTalentModel.instance:getHadConsumeTalentPoint()

	self._txtprogress.text = string.format("<color=%s>%s</color>", "#E99B56", allUnlockNum) .. "/" .. config.cost
	self._txttalenname.text = self._config.name

	local isopen = not lock and not isfull
	local hadUp = RougeTalentModel.instance:getUnlockNumByTalent(self._index) > 0

	gohelper.setActive(self._goprogressunfullLight, isopen and hadUp)
	gohelper.setActive(self._goprogressunfull, not isfull)
	gohelper.setActive(self._goprogressfull, isfull)
end

function RougeTalentTreeItem:_onBackView()
	function self.backopenfunc()
		TaskDispatcher.cancelTask(self.backopenfunc, self)

		local lock = RougeTalentModel.instance:checkBigNodeLock(self._index)

		if self._beforestatus ~= lock then
			gohelper.setActive(self._golocked, true)
			self._animlock:Update(0)
			self._animlock:Play("unlock", 0, 0)

			self._beforestatus = lock
		end
	end

	TaskDispatcher.runDelay(self.backopenfunc, self, self._backViewOpenTime)
end

function RougeTalentTreeItem:dispose()
	self:removeEvents()
	self:__onDispose()
end

return RougeTalentTreeItem
