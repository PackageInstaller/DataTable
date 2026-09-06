-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petrelation/controller/PetRelationController.lua

module("logic.extensions.petrelation.controller.PetRelationController", package.seeall)

local PetRelationController = class("PetRelationController", BaseController)

PetRelationController.KEY_FORM_BOND_IS_SHOW_DETAIL = "Form_Bond_Is_Show_Detail"

local floatItemPrefab

local function createFloatItem()
	local go = goutil.clone(floatItemPrefab)

	return (Framework.LuaComponentContainer.Add(go, PetBondItem))
end

local function destroyFloatItem(obj)
	goutil.destroy(obj.gameObject)
end

local function resetFloatItem(obj)
	obj:reset()
	obj.gameObject:SetActive(false)
	goutil.addChildToParent(obj.gameObject, PetRelationController.instance._defaultRootNode)
end

function PetRelationController:ctor()
	PetRelationController.super.ctor(self)

	self._defaultRootNode = ViewMgr.instance:getRoot(ViewRootType.Top)
	self._floatWordItemContainer = nil
	self._limitItemCount = 3
	self._dieAlphaTime = 1.6
	self._items = Queue.New()
	self._isFling = false
	self._pool = ObjectPool.New(10, createFloatItem, destroyFloatItem, resetFloatItem)
end

function PetRelationController:getDieAlphaTime()
	return self._dieAlphaTime
end

function PetRelationController:initPrefabRes(itemPrefab)
	self._floatWordItemContainer = self._defaultRootNode
	floatItemPrefab = itemPrefab
end

function PetRelationController:setParent(parent)
	self._floatWordItemContainer = parent
end

function PetRelationController:resetParent()
	self._floatWordItemContainer = self._defaultRootNode

	if self._items then
		self._items:traversal(function(key, item)
			goutil.addChildToParent(item.gameObject, self._floatWordItemContainer)
		end)
	end
end

function PetRelationController:_checkSimplePopupParam(param)
	local isLegal = false
	local formInfo = param and param.formInfo
	local showPetFaceId1, showPetFaceId2, showBondName

	if param then
		if not param.bond then
			local bond = {}

			if param then
				if not param.petMoMap then
					local petMoMap = {}

					if #bond >= 2 then
						for i = 1, #bond do
							local petMo = petMoMap[bond[i]]

							if petMo then
								if not showPetFaceId1 then
									showPetFaceId1 = checknumber(petMo.curFaceId)

									if showPetFaceId1 <= 0 then
										showPetFaceId1 = checknumber(petMo.raceId)
									end
								end

								showPetFaceId2 = checknumber(petMo.curFaceId)

								if showPetFaceId2 <= 0 then
									showPetFaceId2 = checknumber(petMo.raceId)
								end
							end
						end

						if showPetFaceId1 > 0 and showPetFaceId2 > 0 then
							showBondName = bond.name
							isLegal = true
						end
					end

					return (formInfo or nil) and true, formInfo, showPetFaceId1, showPetFaceId2, showBondName
				end
			end
		end
	end
end

function PetRelationController:showSimplePopup(param)
	if not self:getIsShowDetail() then
		return
	end

	local isLegal, formInfo, showPetFaceId1, showPetFaceId2, showBondName = self:_checkSimplePopupParam(param)

	if not isLegal then
		return
	end

	if floatItemPrefab == nil then
		if not self._isLoading then
			self._isLoading = true

			local resPath = "ui/views/petrelation/petbonditem.prefab"

			getres(resPath, self._onResLoaded, self)
		end

		self._waitingList = self._waitingList or {}

		table.insert(self._waitingList, param)
	else
		self:_realPopView(param)
	end
end

function PetRelationController:_onResLoaded(res)
	if res and res.IsSuccess then
		res:Retain()
		self:initPrefabRes(res:GetMainAsset())

		if self._waitingList and #self._waitingList then
			for i, v in ipairs(self._waitingList) do
				self:_realPopView(v)
			end
		end
	end
end

function PetRelationController:_realPopView(param)
	local isLegal, formInfo, showPetFaceId1, showPetFaceId2, showBondName = self:_checkSimplePopupParam(param)

	if not isLegal then
		return
	end

	if self._items:count() >= self._limitItemCount then
		local itemPopUp = self._items:dequeue()

		self._pool:returnObject(itemPopUp)
	end

	local item = self._pool:fetchObject()

	goutil.addChildToParent(item.gameObject, self._floatWordItemContainer)
	item.gameObject.transform:SetAsFirstSibling()

	if formInfo then
		item:setFormInfo(formInfo)
	else
		item:setBondInfo(showPetFaceId1, showPetFaceId2, showBondName)
	end

	item:born()
	self._items:enqueue(item)
	self:_showNextSimplePopup()

	if not self._isFling then
		self._isFling = true

		settimer(self._dieAlphaTime, self._onFloatDone, self, true)
	end
end

function PetRelationController:_showNextSimplePopup()
	local itemsCount = self._items:count()

	if itemsCount > 0 then
		local height = 0

		self._items:traversal(function(key, item)
			if not key or not item then
				return
			end

			height = (itemsCount - key) * 80 + 100

			GameUtil.setLocalPos(item._rt.gameObject, 0, height, 0)
			item.gameObject:SetActive(true)
			item:_resetAlpha()
		end)
	end
end

function PetRelationController:_onFloatDone()
	if not self._items then
		return
	end

	local item = self._items:peek()

	if not item then
		return
	end

	item:dying()

	if not item:isLiving() then
		self._items:dequeue()
		self._pool:returnObject(item)
	end

	local itemsCount = self._items:count()

	if itemsCount == 0 then
		self._isFling = false

		removetimer(self._onFloatDone, self)
	end
end

function PetRelationController:onInit()
	PetRelationController.super.onInit(self)
	self:onReset()
end

function PetRelationController:onReset()
	PetRelationController.super.onReset(self)

	self.needShowBonds = {}
	self.petMoMap = {}
end

function PetRelationController:showPetrelationAlertView(bonds, petMoMap)
	self.needShowBonds = self.needShowBonds or {}
	self.petMoMap = petMoMap or {}

	for i, v in ipairs(bonds or {}) do
		table.insert(self.needShowBonds, v)
	end

	if not ViewMgr.instance:isOpen(ViewName.PetrelationAlertView) then
		UIStateManager.instance:open(ViewName.PetrelationAlertView, self.petMoMap)
	end
end

function PetRelationController:getNextShow()
	local bound

	return (self.needShowBonds and #self.needShowBonds > 0 or nil) and table.remove(self.needShowBonds, 1), self.petMoMap
end

function PetRelationController:closePetrelationAlertView()
	self.needShowBonds = {}
	self.petMoMap = {}

	UIStateManager.instance:popByName(ViewName.PetrelationAlertView)
end

function PetRelationController:haveCanActivePet(viewType)
	local petSeat = PetRelationModel.instance:getPetSeat(viewType)

	for k, v in ipairs(petSeat or {}) do
		if HandbookController.instance:getIfCanActive(v.raceId) then
			return true
		end
	end

	local teamIds = PetRelationConfig.instance:getPosterByType(viewType) or {}

	for i, teamId in ipairs(teamIds) do
		if HandbookModel.instance:getIsPosterShowRedPointByTeamId(teamId) then
			return true
		end
	end

	return false
end

function PetRelationController:getIsShowDetail()
	local key = PetRelationController.KEY_FORM_BOND_IS_SHOW_DETAIL

	return checknumber(GameUtil.getUserData(key)) <= 0
end

function PetRelationController:setIsShowDetail(isShow)
	local key = PetRelationController.KEY_FORM_BOND_IS_SHOW_DETAIL
	local saveValue = isShow and 0 or 1

	GameUtil.saveUserData(key, saveValue)
end

PetRelationController.instance = PetRelationController.New()

return PetRelationController
