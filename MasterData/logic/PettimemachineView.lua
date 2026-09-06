-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pettimemachine/view/PettimemachineView.lua

module("logic.extensions.pettimemachine.view.PettimemachineView", package.seeall)

local PettimemachineView = class("PettimemachineView", ViewComponent)

PettimemachineView.RULE_KEY = "timemachine"

function PettimemachineView:ctor()
	PettimemachineView.super.ctor(self)
end

function PettimemachineView:buildUI()
	PettimemachineView.super.buildUI(self)

	self.btnClose = self:getGo("winCon/closeBtn")
	self.tipBtn = self:getGo("winCon/tipBtn")
	self.btnPay = self:getGo("btnPay")
	self.spriteStarBg = self:getGo("spriteStarBg")
	self.txtPay = self:getTxt("btnPay/txt")
	self.txtPayIcon = self:getGo("btnPay/txt/icon")
	self.txtDesc = self:getTxt("txtDesc")
	self.txtCount = self:getTxt("txtCount")
	self.txtPetName = self:getTxt("txtPetName")
	self.txtPetLv = self:getTxt("txtPetLv")
	self.btnAdd = self:getGo("pet/btnAdd")
	self.btnChange = self:getGo("pet/btnChange")
	self.con = self:getGo("pet/con")
	self._goldBarCon = self:getGo("goldBarCon")
	self.imgTitle = self:getGo("imgTitle")
	self.stargod = self:getGo("stargod")
	self.stargodBG = self:getGo("stargod/bg")
	self.txtEmpty = self:getGo("stargod/txtEmpty")
	self.starCell = self:getGo("stargod/starCell")

	GameUtil.SetActive(self.starCell, false)

	self.starCon = self:getGo("stargod/starCon")
	self.txtTip = MaterialMgr.findGraphicText(self.mainGO, "stargod/txtTip")

	local cell = self:getGo("tablecell")
	local cell = self:getGo("tablecell")
	local go = self:getGo("tableview")

	self.scroll = ScrollerList.create(go, cell, GameUtil.handler(self.onUpdateCell, self), GameUtil.handler(self.onClearCell, self))
end

function PettimemachineView:bindEvents()
	PettimemachineView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.tipBtn, self.onHelpClick, self)
	GameUtil.addClickHandler(self.btnAdd, self.onClickAdd, self)
	GameUtil.addClickHandler(self.btnChange, self.onClickAdd, self)
	GameUtil.addClickHandler(self.btnPay, self.onClickPay, self)
end

function PettimemachineView:unbindEvents()
	PettimemachineView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnAdd)
	GameUtil.rmClickHandler(self.btnChange)
	GameUtil.rmClickHandler(self.btnPay)
end

function PettimemachineView:destroyUI()
	PettimemachineView.super.destroyUI(self)
end

function PettimemachineView:onEnter()
	PettimemachineView.super.onEnter(self)

	self.petId = nil

	local list = PayShopConfig.instance:getTimeMachineCfgList()

	self.scroll:reloadData(list)

	if list and #list > 0 then
		self:onClickCell(list[1])
	end

	PayShopController.instance:getLevelTimeMachineInfo(GameUtil.handler(self.refreshUI, self))
	GlobalDispatcher:addListener(PayShopController.NotifyLevelTimeMachineUseSucRes, self.onTimeSuccess, self)
	GlobalDispatcher:addListener(GlobalNotify.BagPetAttrChanged, self._OnPetDataUpdated, self)
	GameUtil.SetActive(self.tipBtn, false)

	local ruleCo = RulesConfig.instance:getRuleCo(PettimemachineView.RULE_KEY)

	if ruleCo then
		GameUtil.SetActive(self.tipBtn, true)
	end
end

function PettimemachineView:onEnterFinished()
	PettimemachineView.super.onEnterFinished(self)
end

function PettimemachineView:onExit()
	PettimemachineView.super.onExit(self)

	self.petId = nil
	self._loader = RoleObjectPool.instance:removeRole(self._loader)

	PayShopController.instance:clearTimeMachineInfoFunc()
	GlobalDispatcher:removeListener(PayShopController.NotifyLevelTimeMachineUseSucRes, self.onTimeSuccess, self)
	GlobalDispatcher:removeListener(GlobalNotify.BagPetAttrChanged, self._OnPetDataUpdated, self)
	self.scroll:dispose()
end

function PettimemachineView:onExitFinished()
	PettimemachineView.super.onExitFinished(self)
end

function PettimemachineView:_OnPetDataUpdated(oldPet, newPet)
	self:onTimeSuccess(oldPet.petId, oldPet, newPet)
end

function PettimemachineView:onClickPay()
	if self.curCfg then
		if self:checkLimitAndShow(self.curCfg) then
			if checknumber(self.petId) > 0 then
				local times = PayShopController.instance:getBuyTimeById(self.curCfg.id)
				local pid = self.curCfg.buyPlanId
				local payCfg = PayShopConfig.instance:getTimeMachinePlanCfg(pid, times + 1)

				if payCfg then
					local content = lang("是否要把精灵等级提升到100级?溢出的经验将以经验果的形式返回。")
					local matType, matId, matNum = MaterialMgr.getMatParams(payCfg.costMp)

					TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum, content, function()
						PayShopController.instance:sendUseLevelTimeMachineReq(self.curCfg.id, self.petId, 0)
					end)
				end
			else
				TipsFacade.instance:openCommonTips(lang("先选精灵"))
			end
		else
			TipsFacade.instance:openCommonTips(lang("本周的使用次数已经用光，下次再来吧"))
		end
	end
end

function PettimemachineView:checkLimitAndShow(cfg)
	local times = PayShopController.instance:getBuyTimeById(cfg.id)

	return times < cfg.limitTimes
end

function PettimemachineView:onHelpClick()
	UIStateManager.instance:open(ViewName.RulesView, PettimemachineView.RULE_KEY)
end

function PettimemachineView:onClickAdd()
	if self.curCfg then
		if self:checkLimitAndShow(self.curCfg) then
			if self.curCfg.type == "pet" then
				self:selectLvlPet()
			else
				self:selectStarGodPet()
			end
		else
			TipsFacade.instance:openCommonTips(lang("本周的使用次数已经用光，下次再来吧"))
		end
	end
end

function PettimemachineView:selectStarGodPet()
	local function onSeletCallBack(data, petIdList)
		if petIdList and #petIdList > 0 then
			self.petId = petIdList[1]

			self:refreshUI()
		end
	end

	local function filterFunc(petMo)
		local slotDatas = petMo:getStarGodPlusSlots()

		for i, slotData in ipairs(slotDatas or {}) do
			if slotData and checknumber(slotData.fillerDefineId) > 0 and not StargodplusModel.instance:isSlotMaxLv(slotData.slot, slotData.exp) then
				return true
			end
		end

		return false
	end

	local title = lang("只显示当前佩戴星神还没满级的精灵")

	UIStateManager.instance:push(ViewName.PettiselectView, 1, title, filterFunc, onSeletCallBack)
end

function PettimemachineView:selectLvlPet()
	local arr = string.splitToNumber(self.curCfg.initRareLimits, ",")
	local rareStr = ""

	if #arr > 0 then
		local tem = {}
		local pool = {}

		for i, v in ipairs(arr) do
			local str = ConstString.PetRareLang[v]

			str = GameUtil.HtmlColorTxt(str, GameUtil.GetGoodsColor(v))

			if pool[v] == nil then
				pool[v] = true

				table.insert(tem, str)
			end
		end

		rareStr = langPara("初始品质为%s的", table.concat(tem, lang("或")))
	end

	local limit = self.curCfg.maxLevelLimit

	local function onSeletCallBack(data, petIdList)
		if petIdList and #petIdList > 0 then
			self.petId = petIdList[1]

			self:refreshUI()
		end
	end

	local function filterFunc(petMo)
		if petMo.level >= limit then
			return false
		end

		local petCo = MaterialMgr.getMatCfg(MatType.Pet, petMo.raceId)

		if petCo and arr and table.indexof(arr, petCo.rare) ~= false then
			return true
		end

		return false
	end

	PetSelectController.instance:OpenView(true, langPara("选择等级低于<color=#eb4642>%s</color>级%s精灵", limit, rareStr), filterFunc, onSeletCallBack, nil)
end

function PettimemachineView:showPet()
	GameUtil.SetActive(self.spriteStarBg, false)

	if self.petId then
		GameUtil.SetActive(self.spriteStarBg, true)
		GameUtil.SetActive(self.btnChange, true)
		GameUtil.SetActive(self.stargodBG, true)
		GameUtil.SetActive(self.btnAdd, false)

		local pet = MaterialMgr.getModel(MatType.Pet, self.petId)

		if pet then
			self.txtPetName.text = pet.name
			self.txtPetLv.text = langPara("当前等级:%s", pet.level)

			local modelCfg = CharactorFacade.instance:getFormationModelUIPosAndScale(pet.curFaceId)
			local x = 0
			local y = 0

			if not modelCfg[3] then
				self._loader = RoleObjectPool.instance:addRoleToParent(self._loader, pet.curFaceId, self.con, modelCfg[3], nil, false, x, y)
			end
		end
	else
		self.txtPetName.text = ""
		self.txtPetLv.text = ""

		GameUtil.SetActive(self.btnChange, false)
		GameUtil.SetActive(self.stargodBG, false)
		GameUtil.SetActive(self.btnAdd, true)

		self._loader = RoleObjectPool.instance:removeRole(self._loader)
	end
end

function PettimemachineView:onUpdateCell(view, cell, cfg)
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

function PettimemachineView:onClearCell(cell)
	return
end

function PettimemachineView:onTimeSuccess(petId, oldPet, newPet)
	if self.petId == petId then
		if self.curCfg then
			if self.curCfg.type == "pet" then
				self.petId = nil

				TipsFacade.instance:openCommonTips(lang("精灵升级成功"))
				UIStateManager.instance:open(ViewName.PetUp, GameEnum.PetUpType.PetUpgrade, newPet, oldPet)
			end
		else
			self.petId = nil
		end
	end

	self:refreshUI()
end

function PettimemachineView:onClickCell(cfg)
	if checknumber(cfg.funcId) > 0 and FuncOpenController.instance:checkFuncIdOrShowLockTips(cfg.funcId) then
		self.curCfg = cfg
		self.petId = nil

		self:refreshUI()
	end
end

function PettimemachineView:refreshUI()
	local viewMgr = ViewMgr.instance

	if viewMgr:isOpen(ViewName.MainTopGoldView) then
		viewMgr:close(ViewName.MainTopGoldView)
	end

	GameUtil.SetActive(self.btnPay, false)
	GameUtil.SetActive(self.btnAdd, false)
	GameUtil.SetActive(self.btnChange, false)
	GameUtil.SetActive(self.txtPayIcon, false)
	GameUtil.SetActive(self.stargod, false)
	GameUtil.SetActive(self.txtEmpty, false)
	self.scroll:refresh()

	self.txtCount.text = ""
	self.txtDesc.text = ""
	self.txtPetName.text = ""
	self.txtPetLv.text = ""

	if self.curCfg then
		local times = PayShopController.instance:getBuyTimeById(self.curCfg.id)
		local pid = self.curCfg.buyPlanId
		local payCfg = PayShopConfig.instance:getTimeMachinePlanCfg(pid, times + 1)
		local left = self.curCfg.limitTimes - times
		local leftStr = ""

		leftStr = left > 0 and "<color=#00ff00>" .. left .. "</color>" or "<color=#ff0000>" .. left .. "</color>"

		if self.curCfg.type == "pet" then
			GameUtil.setUIImageSpriteIdx(self.imgTitle, 0)

			self.txtCount.text = langPara("本周剩余使用次数：%s次", leftStr)

			if times < self.curCfg.limitTimes then
				GameUtil.SetActive(self.btnPay, true)
			end

			self.txtDesc.text = langPara("选择任意低于<color=#eb4642>%s</color>级的精灵，消耗对应物品将精灵天赋提升至【<color=#ebad32>%s</color>】，等级提升至<color=#eb4642>%s</color>级，超出的经验值则<color=#eb4642>100%%</color>以经验果返还！", self.curCfg.maxLevelLimit, self.curCfg.talentDesc, self.curCfg.maxLevelLimit)

			if payCfg then
				if not string.nilorempty(payCfg.costMp) then
					GameUtil.SetActive(self.txtPayIcon, true)

					local type, id, num = MaterialMgr.getMatParams(payCfg.costMp)

					MaterialMgr.setIcon(self.txtPayIcon, type, id)

					self.txtPay.text = "" .. num

					local matName = MaterialMgr.getMaterialsName(type, id)

					MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, {
						{
							showAdd = true,
							id = payCfg.costMp
						}
					})
				end
			else
				self.txtPay.text = lang("升级")
			end
		elseif self.curCfg.type == "starGodPlus" then
			self.txtTip.text = langPara("本周剩余使用次数：%s次", leftStr)

			GameUtil.setUIImageSpriteIdx(self.imgTitle, 1)
			GameUtil.SetActive(self.stargod, true)
			goutil.clearChildren(self.starCon)

			local petMo

			if self.petId then
				petMo = MaterialMgr.getModel(MatType.Pet, self.petId)
			end

			if petMo then
				local slotDatas = petMo:getStarGodPlusSlots()
				local hasSlot = false

				for i, slotData in ipairs(slotDatas or {}) do
					if slotData and checknumber(slotData.fillerDefineId) > 0 then
						hasSlot = true

						local cellGo = goutil.clone(self.starCell, "star_" .. slotData.fillerDefineId)

						GameUtil.SetActive(cellGo, true)
						goutil.addChildToParent(cellGo, self.starCon)

						local btnLevelUp = goutil.findChild(cellGo, "btnLevelUp")
						local txtBtnLevelUp = goutil.findChildTextComponent(cellGo, "btnLevelUp/Text")
						local cell = goutil.findChild(cellGo, "cell")
						local ImgBg = goutil.findChild(cell, "ImgBg")
						local iconGo = goutil.findChild(cell, "icon")
						local effectGo = goutil.findChild(cell, "effect")
						local raycast = goutil.findChild(cell, "raycast")
						local btn = GameUtil.asBtn(cell)
						local lockGo = goutil.findChild(cell, "lock")
						local addGo = goutil.findChild(cell, "add")
						local nameText = goutil.findChildTextComponent(cell, "nameText")
						local lvText = goutil.findChildTextComponent(cell, "lvText")
						local lockTip = goutil.findChildTextComponent(lockGo, "lockTip")
						local nameTextColorChange = nameText.gameObject:GetComponent(ComponentType.UITextColorChange)
						local mo = StargodplusModel.instance:getStarGodMo(slotData.fillerId)
						local quality = mo and mo:getQuality() or 0
						local name = mo and mo:getName() or ""

						nameTextColorChange:SetState(quality)

						nameText.text = name

						local lv = StargodplusModel.instance:getSlotLv(slotData.slot, slotData.exp)

						lvText.text = "Lv." .. lv
						nameText.text = MaterialMgr.getMaterialsName(MatType.StarGodPlus, slotData.fillerDefineId)

						MaterialMgr.setIcon(iconGo, MatType.StarGodPlus, slotData.fillerDefineId)

						local cfg = StargodplusConfig.instance:getFillerCfg(slotData.fillerDefineId)
						local quality = checknumber(cfg.quality)

						nameTextColorChange:SetState(quality)
						GameUtil.setUIImageSpriteIdx(ImgBg, quality + 1)

						if StargodplusModel.instance:isSlotMaxLv(slotData.slot, slotData.exp) then
							GameUtil.SetGray(btnLevelUp, true)
							GameUtil.rmClickHandler(btnLevelUp)

							txtBtnLevelUp.text = "已满级"
						else
							GameUtil.SetGray(btnLevelUp, false)

							txtBtnLevelUp.text = "立刻满级"

							GameUtil.addClickHandler(btnLevelUp, GameUtil.handler(self.onClickStarGodPlusCell, self, i, slotData))
						end
					end
				end
			end

			self.txtDesc.text = lang("选择精灵，消耗对应物品启动时光机，将精灵对应的星神栏位等级提升至<color=#eb4642>满级</color>！已有等级的星神，超出的经验和金币，将在提升后<color=#eb4642>100%</color>返还!")

			if payCfg and not string.nilorempty(payCfg.costMp) then
				local type, id, matNum = MaterialMgr.getMatParams(payCfg.costMp)
				local content = MaterialMgr.getContentMatStr(payCfg.costMp, 50, -10, MaterialMgr.ICON_TYPE_ICON)
				local matName = MaterialMgr.getMaterialsName(type, id)

				self.txtTip.text = langPara("消耗%s【%s】x%s立即满级任意星神栏位，本周剩余次数：%s", content, matName, matNum, leftStr)

				MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, {
					{
						showAdd = true,
						id = payCfg.costMp
					}
				})
			end
		end
	end

	self:showPet()
end

function PettimemachineView:onClickStarGodPlusCell(idx, slotData)
	if self.curCfg then
		if self:checkLimitAndShow(self.curCfg) then
			if checknumber(self.petId) > 0 then
				local times = PayShopController.instance:getBuyTimeById(self.curCfg.id)
				local pid = self.curCfg.buyPlanId
				local payCfg = PayShopConfig.instance:getTimeMachinePlanCfg(pid, times + 1)

				if payCfg then
					if not MaterialMgr.getMatEnough(payCfg.costMp) then
						TipsFacade.instance:openCommonTips(lang("物品不足"))
						MaterialMgr.openGetSourceByStr(payCfg.costMp)

						return
					end

					local lv = StargodplusModel.instance:getSlotLv(slotData.slot, slotData.exp)
					local maxlv = StargodplusModel.instance:getMaxSlotLevel(slotData.slot)
					local resList = StargodplusModel.instance:getSlotCompareList(slotData.fillerDefineId, lv, maxlv)
					local list = {}
					local obj = {}

					obj.txtOld = "Lv." .. lv
					obj.txtNew = "Lv." .. maxlv

					table.insert(list, obj)

					for i, v in ipairs(resList) do
						local tem = {}

						tem.txtOld = v.name .. " +" .. v.preValue
						tem.txtNew = v.name .. " +" .. v.lastValue

						table.insert(list, tem)
					end

					local obj = {}

					obj.txtOld = lang("战力+") .. StargodplusModel.instance:getFillterPower(slotData.fillerDefineId, lv)
					obj.txtNew = lang("战力+") .. StargodplusModel.instance:getFillterPower(slotData.fillerDefineId, maxlv)

					table.insert(list, obj)

					local type, id, num = MaterialMgr.getMatParams(payCfg.costMp)
					local str = langPara("是否花费<color=#20B376>%s</color>个%s把【%s】提升至满级？", num, MaterialMgr.getMaterialsName(type, id), MaterialMgr.getMaterialsName(MatType.StarGodPlus, slotData.fillerDefineId))

					UIStateManager.instance:push(ViewName.PettimemachinepopView, str, list, function()
						PayShopController.instance:sendUseLevelTimeMachineReq(self.curCfg.id, self.petId, slotData.slot, function(msg)
							local ci = msg.changeSetId

							MaterialController.instance:saveChangeSetToTemp(ci)
							UIStateManager.instance:push(ViewName.CommonlvupView, resList, function()
								MaterialController.instance:showChangeSetInTemp(ci)
							end)
							BagPetsController.instance:updateStarGodPlusAttrById(self.petId)
						end)
					end)
				end
			else
				TipsFacade.instance:openCommonTips(lang("请先选精灵"))
			end
		else
			TipsFacade.instance:openCommonTips(lang("本周的使用次数已经用光，下次再来吧"))
		end
	end
end

return PettimemachineView
