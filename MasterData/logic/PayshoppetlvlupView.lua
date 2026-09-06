-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/payshop/view/PayshoppetlvlupView.lua

module("logic.extensions.payshop.view.PayshoppetlvlupView", package.seeall)

local PayshoppetlvlupView = class("PayshoppetlvlupView", ViewComponent)

PayshoppetlvlupView.RULE_KEY = "timemachine"

function PayshoppetlvlupView:ctor()
	PayshoppetlvlupView.super.ctor(self)
end

function PayshoppetlvlupView:buildUI()
	PayshoppetlvlupView.super.buildUI(self)

	self.btnClose = self:getGo("winCon/closeBtn")
	self.tipBtn = self:getGo("winCon/tipBtn")
	self.btnPay = self:getGo("btnPay")
	self.spriteStarBg = self:getGo("spriteStarBg")
	self.txtPay = self:getTxt("btnPay/txt")
	self.txtDesc = self:getTxt("txtDesc")
	self.txtCount = self:getTxt("txtCount")
	self.txtPetName = self:getTxt("txtPetName")
	self.txtPetLv = self:getTxt("txtPetLv")
	self.btnAdd = self:getGo("pet/btnAdd")
	self.btnChange = self:getGo("pet/btnChange")
	self.con = self:getGo("pet/con")

	local cell = self:getGo("tablecell")
	local go = self:getGo("tableview")

	self.scroll = ScrollerList.create(go, cell, GameUtil.handler(self.onUpdateCell, self), GameUtil.handler(self.onClearCell, self))
end

function PayshoppetlvlupView:bindEvents()
	PayshoppetlvlupView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.tipBtn, self.onHelpClick, self)
	GameUtil.addClickHandler(self.btnAdd, self.onClickAdd, self)
	GameUtil.addClickHandler(self.btnChange, self.onClickAdd, self)
	GameUtil.addClickHandler(self.btnPay, self.onClickPay, self)
end

function PayshoppetlvlupView:unbindEvents()
	PayshoppetlvlupView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnAdd)
	GameUtil.rmClickHandler(self.btnChange)
	GameUtil.rmClickHandler(self.btnPay)
end

function PayshoppetlvlupView:destroyUI()
	PayshoppetlvlupView.super.destroyUI(self)
end

function PayshoppetlvlupView:onEnter()
	PayshoppetlvlupView.super.onEnter(self)

	self.activeId = 10001
	self.petId = nil

	local list = PayShopConfig.instance:getTimeMachineCfg(self.activeId)

	self.scroll:reloadData(list)

	if list and #list > 0 then
		self:onClickCell(list[1])
	end

	GlobalDispatcher:addListener(PayShopController.NotifyLevelTimeMachineUseSucRes, self.onTimeSuccess, self)
	GlobalDispatcher:addListener(GlobalNotify.BagPetAttrChanged, self._OnPetDataUpdated, self)
	GameUtil.SetActive(self.tipBtn, false)

	local ruleCo = RulesConfig.instance:getRuleCo(PayshoppetlvlupView.RULE_KEY)

	if ruleCo then
		GameUtil.SetActive(self.tipBtn, true)
	end
end

function PayshoppetlvlupView:onEnterFinished()
	PayshoppetlvlupView.super.onEnterFinished(self)
end

function PayshoppetlvlupView:onExit()
	PayshoppetlvlupView.super.onExit(self)

	self.petId = nil
	self._loader = RoleObjectPool.instance:removeRole(self._loader)

	PayShopController.instance:clearTimeMachineInfoFunc()
	GlobalDispatcher:removeListener(PayShopController.NotifyLevelTimeMachineUseSucRes, self.onTimeSuccess, self)
	GlobalDispatcher:removeListener(GlobalNotify.BagPetAttrChanged, self._OnPetDataUpdated, self)
	self.scroll:dispose()
end

function PayshoppetlvlupView:onExitFinished()
	PayshoppetlvlupView.super.onExitFinished(self)
end

function PayshoppetlvlupView:_OnPetDataUpdated(oldPet, newPet)
	self:onTimeSuccess(oldPet.petId)
	UIStateManager.instance:open(ViewName.PetUp, GameEnum.PetUpType.PetUpgrade, newPet, oldPet)
end

function PayshoppetlvlupView:onClickPay()
	if self.curCfg then
		if self:checkLimitAndShow(self.curCfg) then
			if checknumber(self.petId) > 0 then
				local times = PayShopController.instance:getBuyTimeById(self.curCfg.id)
				local pid = self.curCfg.buyPlanId
				local payCfg = PayShopConfig.instance:getTimeMachinePlanCfg(pid, times + 1)

				if payCfg then
					if string.nilorempty(payCfg.payGoodsId) then
						PayShopController.instance:freeLvlup(self.activeId, self.curCfg.id, self.petId)
					else
						local obj = {}

						obj.id = self.curCfg.id
						obj.pid = self.petId

						local ext = GameUtil.jsonToString(obj)

						PayController.instance:pay(payCfg.payGoodsId, GameEnum.PaySubGoodsType.LEVEL_TIME_MACHINE, self.activeId, ext)
					end
				end
			else
				TipsFacade.instance:openCommonTips(lang("先选精灵"))
			end
		else
			TipsFacade.instance:openCommonTips(lang("本周的使用次数已经用光，下次再来吧"))
		end
	end
end

function PayshoppetlvlupView:checkLimitAndShow(cfg)
	local times = PayShopController.instance:getBuyTimeById(cfg.id)

	return times < cfg.limitTimes
end

function PayshoppetlvlupView:onHelpClick()
	UIStateManager.instance:open(ViewName.RulesView, PayshoppetlvlupView.RULE_KEY)
end

function PayshoppetlvlupView:onClickAdd()
	if self.curCfg then
		if self:checkLimitAndShow(self.curCfg) then
			local arr = string.splitToNumber(self.curCfg.initRareLimits, ",")
			local rareStr = ""

			if #arr > 0 then
				local tem = {}

				for i, v in ipairs(arr) do
					local acfg = CharacterConfig.instance:getAwakenRareCfg(v)
					local str = acfg.desc

					str = GameUtil.HtmlColorTxt(str, GameUtil.GetGoodsColor(acfg.rare))

					table.insert(tem, str)
				end

				rareStr = langPara("初始品质为%s的", table.concat(tem, lang("或")))
			end

			local limit = self.curCfg.targetLevel

			local function onSeletCallBack(data, petIdList)
				if petIdList and #petIdList > 0 then
					self.petId = petIdList[1]

					self:showPet()
				end
			end

			local function filterFunc(petMo)
				if petMo.level >= limit then
					return false
				end

				local petCo = MaterialMgr.getMatCfg(MatType.Pet, petMo.raceId)

				if petCo and arr and table.indexof(arr, petCo.initAwakenLv) ~= false then
					return true
				end

				return false
			end

			PetSelectController.instance:OpenView(true, langPara("选择等级低于<color=#eb4642>%s</color>级%s精灵", limit, rareStr), filterFunc, onSeletCallBack, nil)
		else
			TipsFacade.instance:openCommonTips(lang("本周的使用次数已经用光，下次再来吧"))
		end
	end
end

function PayshoppetlvlupView:showPet()
	GameUtil.SetActive(self.spriteStarBg, false)

	if self.petId then
		GameUtil.SetActive(self.spriteStarBg, true)
		GameUtil.SetActive(self.btnChange, true)
		GameUtil.SetActive(self.btnAdd, false)

		local pet = MaterialMgr.getModel(MatType.Pet, self.petId)

		self.txtPetName.text = pet.name
		self.txtPetLv.text = langPara("当前等级:%s", pet.level)

		local modelCfg = CharactorFacade.instance:getFormationModelUIPosAndScale(pet.curFaceId)
		local x = 0
		local y = 0

		if not modelCfg[3] then
			self._loader = RoleObjectPool.instance:addRoleToParent(self._loader, pet.curFaceId, self.con, modelCfg[3], nil, false, x, y)
		end
	else
		self.txtPetName.text = ""
		self.txtPetLv.text = ""

		GameUtil.SetActive(self.btnChange, false)
		GameUtil.SetActive(self.btnAdd, true)

		self._loader = RoleObjectPool.instance:removeRole(self._loader)
	end
end

function PayshoppetlvlupView:onUpdateCell(view, cell, cfg)
	local txt = goutil.findChildTextComponent(cell, "btn/text")

	txt.text = cfg.name

	local btn = goutil.findChild(cell, "btn")
	local imgBg = goutil.findChild(cell, "imgBg")
	local imgSmallBg = goutil.findChild(cell, "imgSmallBg")
	local imgLock = goutil.findChild(cell, "imgLock")
	local lock = checknumber(cfg.funcId) == 0 or FuncOpenModel.instance:getFuncIsOpen(cfg.funcId)

	GameUtil.SetActive(imgLock, not lock)
	GameUtil.SetActive(imgBg, false)
	GameUtil.SetActive(imgSmallBg, false)

	if self.curCfg == cfg then
		GameUtil.SetActive(imgBg, true)
		GameUtil.setUIGroupIdx(cell, 1)
	else
		GameUtil.SetActive(imgSmallBg, true)
		GameUtil.setUIGroupIdx(cell, 0)
	end

	GameUtil.addClickHandler(btn, GameUtil.handler(self.onClickCell, self, cfg))
end

function PayshoppetlvlupView:onClearCell(cell)
	return
end

function PayshoppetlvlupView:onTimeSuccess(petId)
	if self.petId == petId then
		self.petId = nil

		TipsFacade.instance:openCommonTips(lang("精灵升级成功"))
	end

	print(">>>>>>>>>>>>>>>>>>> PayshoppetlvlupView onNotifyLevelTimeMachineUseSucRes", petId)
	self:refreshUI()
end

function PayshoppetlvlupView:onClickCell(cfg)
	if checknumber(cfg.funcId) > 0 and FuncOpenController.instance:checkFuncIdOrShowLockTips(cfg.funcId) then
		self.curCfg = cfg
		self.petId = nil

		self:refreshUI()
	end
end

function PayshoppetlvlupView:refreshUI()
	GameUtil.SetActive(self.btnPay, false)
	GameUtil.SetActive(self.btnAdd, false)
	GameUtil.SetActive(self.btnChange, false)
	self.scroll:refresh()

	self.txtCount.text = langPara("本周剩余使用次数：%s次", 0)
	self.txtDesc.text = ""
	self.txtPetName.text = ""
	self.txtPetLv.text = ""

	if self.curCfg then
		local times = PayShopController.instance:getBuyTimeById(self.curCfg.id)

		self.txtDesc.text = langPara("选择精灵，花费一定金额启动时光机，将精灵天赋提升至<color=#ebad32>%s</color>，等级提升至<color=#eb4642>%s</color>级！", self.curCfg.talentDesc, self.curCfg.targetLevel)

		GameUtil.SetGray(self.btnAdd, true)

		if times < self.curCfg.limitTimes then
			GameUtil.SetGray(self.btnAdd, false)
			GameUtil.SetActive(self.btnPay, true)
		end

		self.txtCount.text = langPara("本周剩余使用次数：%s次", self.curCfg.limitTimes - times)

		local pid = self.curCfg.buyPlanId
		local payCfg = PayShopConfig.instance:getTimeMachinePlanCfg(pid, times + 1)

		self.txtPay.text = payCfg and payCfg.label or lang("升级")
	end

	self:showPet()
end

return PayshoppetlvlupView
