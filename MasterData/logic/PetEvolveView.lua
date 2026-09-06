-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/evolve/view/PetEvolveView.lua

module("logic.extensions.evolve.view.PetEvolveView", package.seeall)

local PetEvolveView = class("PetEvolveView", ViewComponent)

function PetEvolveView:ctor()
	PetEvolveView.super.ctor(self)

	self.raceId = 10003
	self._raceIdBefore = 0
	self._evolveBagId = 0
	self._callBack = nil
	self._itemStr = nil
end

function PetEvolveView:bindEvents()
	self._closeBtn:AddClickListener(self._onClose, self)
	self._putPet:AddClickListener(self._onPutPet, self)
	self._btnEvolve:AddClickListener(self._onEvolve, self)
end

function PetEvolveView:unbindEvents()
	self._closeBtn:RemoveClickListener()
	self._putPet:RemoveClickListener()
	self._btnEvolve:RemoveClickListener()
end

function PetEvolveView:buildUI()
	self._closeBtn = self:getBtn("closeBtn")
	self._topTip = self:getGo("topTip"):GetComponent("Text")
	self._putPetTxt = self:getGo("putPet/Text"):GetComponent("Text")
	self._bigName = self:getGo("evolveAfter/name/Text"):GetComponent("Text")
	self._smallName = self:getGo("evolveBefore/name/Text"):GetComponent("Text")
	self._evolveBefore = self:getGo("evolveBefore/con")
	self._evolveAfter = self:getGo("evolveAfter/con")
	self._putPet = self:getBtn("putPet")
	self._btnEvolve = self:getBtn("btnEvolve")
	self._icon = self:getGo("icon")
	self._imgArrow = self:getGo("imgArrow")
	self._materialGo = self:getGo("material")
	self._txtNeed = self:getTxt("material/txtNeed")
	self._itemGo = self:getGo("material/item")

	self._btnEvolve.gameObject:SetActive(false)
end

function PetEvolveView:destroyUI()
	return
end

function PetEvolveView:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.EvolveSuccess, self._onPetEvolveSuccess, self)

	self._evolveBagId = -1
	self._callBack = nil
	self._arrRaceIdBefore = nil
	self._itemStr = nil

	self:_setIsMatchCondition(true)
	self._evolveBefore.gameObject:SetActive(false)

	if self._viewPresentor._openParam then
		self._evolveMo = self._viewPresentor._openParam[1]

		if self._evolveMo then
			if self._evolveMo.isItem then
				self._itemStr = self._evolveMo.itemStr
				self._raceIdBefore, self.raceId, self._itemStr = self:_getRaceIdByItemStr(self._evolveMo.itemStr)
			else
				self._raceIdBefore = self._evolveMo.raceIdBefore
				self.raceId = self._evolveMo.raceIdAfter
				self._itemStr = self:_getItemStrBy(self._raceIdBefore, self.raceId)
			end

			self._arrRaceIdBefore = {
				self._raceIdBefore
			}
		end

		if self._evolveMo.callback then
			self._callBack = self._evolveMo.callback
		end
	else
		return nil
	end

	printInfo("test id", self._raceIdBefore, self.raceId)

	local petCoAfter = CharacterConfig.instance:getPetCo(self.raceId)
	local petCoBefore = CharacterConfig.instance:getPetCo(checknumber(self._raceIdBefore))

	self._bigName.text = petCoAfter.name
	self._smallName.text = petCoBefore.name
	self._topTip.text = string.format(lang("evlove_toptip"), petCoBefore.name)
	self._afterFaceId = checknumber(petCoAfter.faceIds)

	local modelCfg = CharactorFacade.instance:getEvolveViewModelUIPosAndScale(tonumber(self._afterFaceId))

	if not modelCfg[1] then
		if not modelCfg[2] then
			local y = 0

			if not modelCfg[3] then
				local scale = 1

				self._loader_a = RoleObjectPool.instance:addRoleToParent(self._loader_a, self._afterFaceId, self._evolveAfter, scale, function(go)
					printInfo("change mat")

					local r = goutil.findChildComponent(go, "skeleton", "SkeletonGraphic")
					local mat = UnityEngine.Material.New(Framework.ShaderCache.Find("Spine/Skeleton Fill"))

					mat.mainTexture = r.material.mainTexture
					r.material = mat

					mat:SetFloat("_FillPhase", 1)
					GoUtil.SetMatColor(mat, "_FillColor", 0.596078431372549, 0.7137254901960784, 0.807843137254902, 1)
				end, false, modelCfg[1], y)

				self:_initCostMatItem()
				self:_onSeletCallBack(self._evolveBagId)
			end
		end
	end
end

function PetEvolveView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.EvolveSuccess, self._onPetEvolveSuccess, self)

	self._loader_a = RoleObjectPool.instance:removeRole(self._loader_a)
	self._loader_b = RoleObjectPool.instance:removeRole(self._loader_b)

	self:_removeItemGo()
end

function PetEvolveView:_onClose()
	self:close()
end

function PetEvolveView:_onEvolve()
	if not self:_isMatchCondition() then
		FloatWordMgr.instance:show("请先收集足够的材料哦~")

		return
	end

	if self._callBack then
		self._callBack(self._evolveBagId)
		self:_onClose()
	else
		self:_defaultEvolveCallback(self._evolveBagId)
	end
end

function PetEvolveView:_onPutPet()
	if self._evolveBagId ~= -1 then
		self:_onEvolve()
	else
		if self._raceIdBefore == 0 then
			return nil
		end

		if not self:_hasAnyPet() then
			FloatWordMgr.instance:show("没有符合要求的精灵哦~")
		else
			function onSeletCallBack(evolveBagId)
				if evolveBagId then
					self:_onSeletCallBack(evolveBagId)
				else
					self:_onSeletCallBack(-1)
				end
			end

			function filterFunc(petData)
				for i, v in ipairs(self._arrRaceIdBefore) do
					if v == petData.raceId then
						return true
					end
				end

				return false
			end

			PetSelectController.instance:OpenViewWithOnce("", filterFunc, onSeletCallBack)
		end
	end
end

function PetEvolveView:_hasAnyPet()
	local has = false

	for i, v in ipairs(self._arrRaceIdBefore) do
		local num = BagPetsFacade.instance:getPetNumByRaceId(v)

		has = num > 0

		if has then
			return true
		end
	end

	return has
end

function PetEvolveView:_onSeletCallBack(evolveBagId)
	local petCoBefore = CharacterConfig.instance:getPetCo(checknumber(self._raceIdBefore))

	self._beforeFaceId = checknumber(petCoBefore.faceIds)
	self._loader_b = RoleObjectPool.instance:removeRole(self._loader_b)
	self._evolveBagId = evolveBagId

	if self._evolveBagId ~= -1 then
		self._putPet.gameObject:SetActive(false)
		self._btnEvolve.gameObject:SetActive(true)
	else
		self._putPet.gameObject:SetActive(true)
		self._btnEvolve.gameObject:SetActive(false)
	end

	if self._evolveBagId ~= -1 then
		local modelCfg = CharactorFacade.instance:getEvolveViewModelUIPosAndScale(tonumber(self._beforeFaceId))

		if not modelCfg[1] then
			if not modelCfg[2] then
				local y = 0

				if not modelCfg[3] then
					local scale = 1

					self._evolveBefore.gameObject:SetActive(true)

					self._loader_b = RoleObjectPool.instance:addRoleToParent(self._loader_b, self._beforeFaceId, self._evolveBefore, scale, nil, false, modelCfg[1], y)
				end
			end
		end
	end
end

function PetEvolveView:_defaultEvolveCallback(selectPetId)
	EvolveController.instance:sendPM_EvolvePetReq(selectPetId, self.raceId)
end

function PetEvolveView:_onPetEvolveSuccess()
	printInfo("test 开始播放动画")
	EvolveController.instance:playEvolveAnimation(self._raceIdBefore, self.raceId)
	self:_onClose()
end

function PetEvolveView:_getItemStrBy(preRaceId, postRaceId)
	local cfg = EvolveConfig.instance:getCfgById(preRaceId, postRaceId)

	if cfg and not string.nilorempty(cfg.cost) then
		return cfg.cost
	end

	return nil
end

function PetEvolveView:_getRaceIdByItemStr(itemStr)
	local cfg = EvolveConfig.instance:getCfgByCost(itemStr)

	if cfg then
		return cfg.raceId, cfg.newRaceId, cfg.cost
	end

	printError("_getRaceIdByItemStr 找不到对应配置", itemStr, type(itemStr))

	return 0, 0, ""
end

function PetEvolveView:_initCostMatItem()
	if not string.nilorempty(self._itemStr) then
		self._materialGo:SetActive(true)
		self._imgArrow:SetActive(false)
		self:_setItemGo()

		local list = string.split(self._itemStr, ":")

		if #list >= 3 then
			local name = MaterialMgr.getMaterialsName(list[1], list[2])
			local needNum = checknumber(list[3])
			local curNum = checknumber(MaterialModel.instance:getMaterialsNumber(list[1], list[2]))
			local colorStr = needNum <= curNum and "20b376" or "eb4642"

			self:_setIsMatchCondition(needNum <= curNum)

			self._txtNeed.text = name .. "\n" .. string.format("(<color=#%s>%d</color>/%d)", colorStr, curNum, needNum)
		else
			self._txtNeed.text = ""
		end
	else
		self._materialGo:SetActive(false)
		self._imgArrow:SetActive(true)
	end
end

function PetEvolveView:_setItemGo()
	local proxy = MaterialMgr.setCellByCfg(self._itemStr, self._itemGo)

	proxy.binder:setNum(0)
end

function PetEvolveView:_removeItemGo()
	MaterialMgr.resetAll(self._itemGo)
end

function PetEvolveView:_isMatchCondition()
	return self._isMatch
end

function PetEvolveView:_setIsMatchCondition(state)
	self._isMatch = state
end

return PetEvolveView
