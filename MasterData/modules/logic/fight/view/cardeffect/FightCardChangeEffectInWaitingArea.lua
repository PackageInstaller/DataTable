-- chunkname: @modules/logic/fight/view/cardeffect/FightCardChangeEffectInWaitingArea.lua

module("modules.logic.fight.view.cardeffect.FightCardChangeEffectInWaitingArea", package.seeall)

local FightCardChangeEffectInWaitingArea = class("FightCardChangeEffectInWaitingArea", BaseWork)

function FightCardChangeEffectInWaitingArea:onStart(context)
	FightCardChangeEffectInWaitingArea.super.onStart(self, context)

	self._paramDict = {}

	self:_playEffects()
	TaskDispatcher.runDelay(self._removeDownEffect, self, 1.2 / FightModel.instance:getUISpeed())
	TaskDispatcher.runDelay(self._delayDone, self, 1.5 / FightModel.instance:getUISpeed())
end

function FightCardChangeEffectInWaitingArea:_playEffects()
	self._effectGOList = {}
	self._effectLoaderList = {}

	local needPlayCardItems = {}
	local targetChangeInfos = {}

	for _, changeInfo in ipairs(self.context.changeInfos) do
		for _, cardItem in ipairs(self.context.cardItemList) do
			local active = cardItem.go.activeInHierarchy
			local prevLvId = FightCardDataHelper.getSkillPrevLvId(cardItem.entityId, cardItem.skillId)
			local nextLvId = FightCardDataHelper.getSkillNextLvId(cardItem.entityId, cardItem.skillId)

			if active and prevLvId and prevLvId == changeInfo.targetSkillId then
				if not tabletool.indexOf(needPlayCardItems, cardItem) then
					table.insert(needPlayCardItems, cardItem)
					table.insert(targetChangeInfos, changeInfo)
				end
			elseif active and nextLvId and nextLvId == changeInfo.targetSkillId and not tabletool.indexOf(needPlayCardItems, cardItem) then
				table.insert(needPlayCardItems, cardItem)
				table.insert(targetChangeInfos, changeInfo)
			end
		end
	end

	if #needPlayCardItems > 0 then
		for i, cardItem in ipairs(needPlayCardItems) do
			local targetSkillInfo = targetChangeInfos[i]
			local targetEntityId = targetSkillInfo.entityId
			local targetSkillId = targetSkillInfo.targetSkillId
			local oldCardLevel = FightCardDataHelper.getSkillLv(cardItem.entityId, cardItem.skillId)
			local cardItemGO = cardItem.go
			local changeEffectGO = gohelper.findChild(cardItemGO, "lvChangeEffect") or gohelper.create2d(cardItemGO, "lvChangeEffect")
			local effectLoader = PrefabInstantiate.Create(changeEffectGO)
			local newCardLevel = FightCardDataHelper.getSkillLv(targetEntityId, targetSkillId)

			if newCardLevel ~= oldCardLevel then
				self._paramDict[effectLoader] = {
					newCardLevel = newCardLevel,
					oldCardLevel = oldCardLevel
				}

				local cardSkin = FightCardDataHelper.getCardSkin()

				if not FightCardChangeEffect.cardSkin2LvUpEffectPath[cardSkin] then
					local lvUpEffectPath = FightPreloadOthersWork.LvUpEffectPath

					if not FightCardChangeEffect.cardSkin2LvDownEffectPath[cardSkin] then
						local lvDownEffectPath = FightPreloadOthersWork.LvDownEffectPath
						local effectPath = oldCardLevel < newCardLevel and lvUpEffectPath or lvDownEffectPath

						effectLoader:startLoad(effectPath, self._onLvEffectLoaded, self)

						if oldCardLevel < newCardLevel then
							if not ViewAnim.LvUpAnimPath then
								local animPath = ViewAnim.LvDownAnimPath
								local animLoader = MultiAbLoader.New()

								self._paramDict[animLoader] = {
									newCardLevel = newCardLevel,
									oldCardLevel = oldCardLevel,
									cardItem = cardItem
								}

								animLoader:addPath(animPath)
								animLoader:startLoad(self._onLvAnimLoaded, self)

								self._animLoaderList = self._animLoaderList or {}

								table.insert(self._animLoaderList, animLoader)
							end
						end
					end
				end
			else
				logError("手牌星级变更失败，等级相同：" .. cardItem.skillId .. " -> " .. targetSkillId)
			end

			table.insert(self._effectGOList, changeEffectGO)
			table.insert(self._effectLoaderList, effectLoader)

			cardItem.op.skillId = targetSkillId
		end
	else
		self:onDone(true)
	end
end

function FightCardChangeEffectInWaitingArea:_onLvEffectLoaded(effectLoader)
	local param = self._paramDict[effectLoader]
	local newCardLevel = param.newCardLevel
	local oldCardLevel = param.oldCardLevel

	if oldCardLevel < newCardLevel then
		gohelper.setActive(gohelper.findChild(effectLoader:getInstGO(), "cardrising01"), newCardLevel == 2)
		gohelper.setActive(gohelper.findChild(effectLoader:getInstGO(), "cardrising02"), newCardLevel == 3)
	else
		gohelper.setActive(gohelper.findChild(effectLoader:getInstGO(), "starescending01"), newCardLevel == 1)
		gohelper.setActive(gohelper.findChild(effectLoader:getInstGO(), "starescending02"), newCardLevel == 2)
	end
end

function FightCardChangeEffectInWaitingArea:_onLvAnimLoaded(animLoader)
	local param = self._paramDict[animLoader]
	local newCardLevel = param.newCardLevel
	local oldCardLevel = param.oldCardLevel
	local cardItem = param.cardItem
	local cardGO = cardItem.go

	gohelper.setActive(gohelper.findChild(cardGO, "star/star1"), newCardLevel == 1 or oldCardLevel == 1)
	gohelper.setActive(gohelper.findChild(cardGO, "star/star2"), newCardLevel == 2 or oldCardLevel == 2)
	gohelper.setActive(gohelper.findChild(cardGO, "star/star3"), newCardLevel == 3 or oldCardLevel == 3)
	gohelper.onceAddComponent(gohelper.findChild(cardGO, "lv1"), typeof(UnityEngine.UI.RectMask2D))
	gohelper.onceAddComponent(gohelper.findChild(cardGO, "lv2"), typeof(UnityEngine.UI.RectMask2D))
	gohelper.onceAddComponent(gohelper.findChild(cardGO, "lv3"), typeof(UnityEngine.UI.RectMask2D))
	gohelper.onceAddComponent(gohelper.findChild(cardGO, "star/star1"), typeof(UnityEngine.CanvasGroup))
	gohelper.onceAddComponent(gohelper.findChild(cardGO, "star/star2"), typeof(UnityEngine.CanvasGroup))
	gohelper.onceAddComponent(gohelper.findChild(cardGO, "star/star3"), typeof(UnityEngine.CanvasGroup))

	local lockGO = gohelper.findChild(cardItem.go, "lock")

	if lockGO and lockGO.activeSelf then
		gohelper.setActive(lockGO, false)

		self._lockGO = lockGO
	end

	local stateName
	local scaleX, _, _ = transformhelper.getLocalScale(cardItem.tr.parent)

	stateName = oldCardLevel < newCardLevel and (scaleX == 1 and (newCardLevel == 2 and "fightcard_rising03" or "fightcard_rising4") or newCardLevel == 2 and "fightcard_rising01" or "fightcard_rising02") or scaleX == 1 and (newCardLevel == 1 and "fightcard_escending03" or "fightcard_escending04") or newCardLevel == 1 and "fightcard_escending01" or "fightcard_escending02"

	local animator = gohelper.onceAddComponent(cardGO, typeof(UnityEngine.Animator))

	animator.runtimeAnimatorController = nil
	animator.runtimeAnimatorController = animLoader:getFirstAssetItem():GetResource()
	animator.speed = FightModel.instance:getUISpeed()

	animator:Play(stateName, 0, 0)
	animator:Update(0)

	self._animCompList = self._animCompList or {}

	table.insert(self._animCompList, animator)
	gohelper.setActiveCanvasGroup(gohelper.findChild(cardGO, "lv1"), newCardLevel == 1 or oldCardLevel == 1)
	gohelper.setActiveCanvasGroup(gohelper.findChild(cardGO, "lv2"), newCardLevel == 2 or oldCardLevel == 2)
	gohelper.setActiveCanvasGroup(gohelper.findChild(cardGO, "lv3"), newCardLevel == 3 or oldCardLevel == 3)
end

function FightCardChangeEffectInWaitingArea:_delayDone()
	if self._lockGO then
		gohelper.setActive(self._lockGO, true)

		self._lockGO = nil
	end

	self:onDone(true)
end

function FightCardChangeEffectInWaitingArea:clearWork()
	TaskDispatcher.cancelTask(self._removeDownEffect, self)
	TaskDispatcher.cancelTask(self._delayDone, self)
	self:_removeDownEffect()
	self:_removeLvAnim()

	self._imgList = nil
	self._lockGO = nil
	self._paramDict = nil
end

function FightCardChangeEffectInWaitingArea:_removeDownEffect()
	if self._effectLoaderList then
		for _, prefabInstantiate in ipairs(self._effectLoaderList) do
			prefabInstantiate:dispose()
		end
	end

	if self._effectGOList then
		for _, go in ipairs(self._effectGOList) do
			gohelper.destroy(go)
		end
	end

	self._effectGOList = nil
	self._effectLoaderList = nil
end

function FightCardChangeEffectInWaitingArea:_removeLvAnim()
	if self._animLoaderList then
		for _, loader in ipairs(self._animLoaderList) do
			loader:dispose()
		end
	end

	self._animLoaderList = nil

	if self._animCompList then
		for _, animComp in ipairs(self._animCompList) do
			if not gohelper.isNil(animComp) then
				animComp.runtimeAnimatorController = nil

				gohelper.removeComponent(gohelper.findChild(animComp.gameObject, "lv1"), typeof(UnityEngine.UI.RectMask2D))
				gohelper.removeComponent(gohelper.findChild(animComp.gameObject, "lv2"), typeof(UnityEngine.UI.RectMask2D))
				gohelper.removeComponent(gohelper.findChild(animComp.gameObject, "lv3"), typeof(UnityEngine.UI.RectMask2D))
				gohelper.removeComponent(gohelper.findChild(animComp.gameObject, "star/star1"), typeof(UnityEngine.CanvasGroup))
				gohelper.removeComponent(gohelper.findChild(animComp.gameObject, "star/star2"), typeof(UnityEngine.CanvasGroup))
				gohelper.removeComponent(gohelper.findChild(animComp.gameObject, "star/star3"), typeof(UnityEngine.CanvasGroup))
			end
		end
	end

	self._animCompList = nil
end

return FightCardChangeEffectInWaitingArea
