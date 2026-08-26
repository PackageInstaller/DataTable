-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotCollectionHelper.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionHelper", package.seeall)

local V1a6_CachotCollectionHelper = class("V1a6_CachotCollectionHelper")

function V1a6_CachotCollectionHelper.refreshSkillDesc(collectionCfg, parentGo, skillItemGo, overrideSkillCB, overrideEffectCB, overrideCallBackObj)
	local skillList, effectList = V1a6_CachotCollectionConfig.instance:getCollectionSkillsInfo(collectionCfg)

	if skillList then
		if not #skillList then
			local skillCount = 0

			tabletool.addValues(skillList, effectList)

			local skillCallBack = overrideSkillCB or V1a6_CachotCollectionHelper._refreshSingleSkillDesc
			local effectCallBack = overrideEffectCB or V1a6_CachotCollectionHelper._refreshSingleEffectDesc
			local callBackObj = overrideCallBackObj or V1a6_CachotCollectionHelper

			gohelper.CreateObjList(callBackObj, skillCallBack, skillList, parentGo, skillItemGo, nil, 1, skillCount)
			gohelper.CreateObjList(callBackObj, effectCallBack, skillList, parentGo, skillItemGo, nil, skillCount + 1)
		end
	end
end

function V1a6_CachotCollectionHelper.refreshSkillDescWithoutEffectDesc(collectionCfg, parentGo, skillItemGo, overrideSkillCB, overrideCallBackObj)
	local skillList = V1a6_CachotCollectionConfig.instance:getCollectionSkillsByConfig(collectionCfg)

	if skillList then
		if not #skillList then
			local skillCount = 0
			local skillCallBack = overrideSkillCB or V1a6_CachotCollectionHelper._refreshSingleSkillDesc
			local callBackObj = overrideCallBackObj or V1a6_CachotCollectionHelper

			gohelper.CreateObjList(callBackObj, skillCallBack, skillList, parentGo, skillItemGo, nil, 1, skillCount)
		end
	end
end

function V1a6_CachotCollectionHelper:_refreshSingleSkillDesc(obj, skillId, index)
	local skillCfg = lua_rule.configDict[skillId]

	if skillCfg then
		if not skillCfg.desc then
			local skillDesc = ""
			local txtEffectDesc = gohelper.findChildText(obj, "txt_desc")

			txtEffectDesc.text = HeroSkillModel.instance:skillDesToSpot(skillDesc)
		end
	end
end

function V1a6_CachotCollectionHelper:_refreshSingleEffectDesc(obj, effectId, index)
	local effectCfg = SkillConfig.instance:getSkillEffectDescCo(effectId)

	if effectCfg then
		local txtEffectDesc = gohelper.findChildText(obj, "txt_desc")
		local info = string.format("[%s]:%s", effectCfg.name, effectCfg.desc)

		txtEffectDesc.text = HeroSkillModel.instance:skillDesToSpot(info)
	end
end

function V1a6_CachotCollectionHelper.refreshEnchantDesc(collectionCfg, parentGo, spDescItemGo, overrideCallBack, overrideCallBackObj)
	local spDescs = V1a6_CachotCollectionConfig.instance:getCollectionSpDescsByConfig(collectionCfg)
	local callBack = overrideCallBack or V1a6_CachotCollectionHelper._refreshSingleEnchantDesc
	local callBackObj = overrideCallBackObj or V1a6_CachotCollectionHelper

	gohelper.CreateObjList(callBackObj, callBack, spDescs, parentGo, spDescItemGo)
end

function V1a6_CachotCollectionHelper:_refreshSingleEnchantDesc(obj, enchantDesc, index)
	local txtDesc = gohelper.findChildText(obj, "txt_desc")

	txtDesc.text = HeroSkillModel.instance:skillDesToSpot(enchantDesc)
end

function V1a6_CachotCollectionHelper.isCollectionBagCanEnchant()
	local isCollectionHoleEmpty = false
	local isCollectionUnEnchant = false
	local rogueInfo = V1a6_CachotModel.instance:getRogueInfo()

	if rogueInfo then
		local collections = rogueInfo.collections
		local enchants = rogueInfo.enchants

		if enchants then
			if not #enchants then
				local enchantNum = 0

				if collections then
					if not #collections then
						local collectionNum = 0

						if enchantNum <= 0 or collectionNum <= 0 then
							return false
						end

						for index = 1, collectionNum do
							local collection = collections[index]

							isCollectionHoleEmpty, isCollectionUnEnchant = V1a6_CachotCollectionHelper.isCollectionHoleEmptyOrUnEnchant(collection, isCollectionHoleEmpty, isCollectionUnEnchant)

							if isCollectionHoleEmpty and isCollectionUnEnchant then
								break
							end
						end
					end
				end
			end
		end
	end

	return isCollectionHoleEmpty and isCollectionUnEnchant
end

function V1a6_CachotCollectionHelper.isCollectionHoleEmptyOrUnEnchant(collectionMO, isCollectionHoleEmpty, isCollectionUnEnchant)
	local collectionCfg = V1a6_CachotCollectionConfig.instance:getCollectionConfig(collectionMO.cfgId)
	local collectionType = collectionCfg.type

	if collectionType ~= V1a6_CachotEnum.CollectionType.Enchant and not isCollectionHoleEmpty then
		local holeNum = collectionCfg.holeNum
		local enchantCount = collectionMO:getEnchantCount()

		isCollectionHoleEmpty = isCollectionHoleEmpty or enchantCount < holeNum
	elseif collectionType == V1a6_CachotEnum.CollectionType.Enchant and not isCollectionUnEnchant then
		local isEnchant = collectionMO:isEnchant()

		isCollectionUnEnchant = isCollectionUnEnchant or not isEnchant
	end

	return isCollectionHoleEmpty, isCollectionUnEnchant
end

function V1a6_CachotCollectionHelper.createCollectionHoles(collectionCfg, holeParentGO, sourceHoleGO)
	if collectionCfg then
		if not collectionCfg.holeNum then
			local holeNum = 0

			gohelper.CreateNumObjList(holeParentGO, sourceHoleGO, holeNum)
		end
	end
end

function V1a6_CachotCollectionHelper.refreshCollectionUniqueTip(collectionCfg, txtTipComp, goTipParent)
	local isUnique = collectionCfg and collectionCfg.unique == 1

	if isUnique then
		if txtTipComp then
			txtTipComp.text = collectionCfg.showRare == V1a6_CachotEnum.CollectionShowRare.Boss and luaLang("v1a6_cachotcollection_bossunique") or luaLang("p_v1a6_cachot_collectionbagview_txt_uniquetips")
		end
	end

	if goTipParent then
		gohelper.setActive(goTipParent, isUnique)
	end
end

return V1a6_CachotCollectionHelper
