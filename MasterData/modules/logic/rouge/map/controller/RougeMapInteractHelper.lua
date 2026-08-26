-- chunkname: @modules/logic/rouge/map/controller/RougeMapInteractHelper.lua

module("modules.logic.rouge.map.controller.RougeMapInteractHelper", package.seeall)

local RougeMapInteractHelper = class("RougeMapInteractHelper")

function RougeMapInteractHelper.triggerInteractive()
	local cutInteract = RougeMapModel.instance:getCurInteractive()

	if string.nilorempty(cutInteract) then
		return
	end

	local interactArr = string.splitToNumber(cutInteract, "#")
	local interactType, interactParam = interactArr[1], interactArr[2]

	RougeMapInteractHelper._initInteractHandle()

	local handle = RougeMapInteractHelper.handleDict[interactType]

	if not handle then
		logError("not found interact type .. " .. tostring(interactType))

		return
	end

	handle(interactParam)
end

function RougeMapInteractHelper._initInteractHandle()
	RougeMapInteractHelper.handleDict = RougeMapInteractHelper.handleDict or {
		[RougeMapEnum.InteractType.Drop] = RougeMapInteractHelper.handleDrop,
		[RougeMapEnum.InteractType.LossCollection] = RougeMapInteractHelper.handleLoss,
		[RougeMapEnum.InteractType.ReturnBlood] = RougeMapInteractHelper.handleReturnBlood,
		[RougeMapEnum.InteractType.Resurgence] = RougeMapInteractHelper.handleResurgence,
		[RougeMapEnum.InteractType.Recruit] = RougeMapInteractHelper.handleRecruit,
		[RougeMapEnum.InteractType.DropGroup] = RougeMapInteractHelper.handleDropGroup,
		[RougeMapEnum.InteractType.LossAndCopy] = RougeMapInteractHelper.handleLossAndCopy,
		[RougeMapEnum.InteractType.LossAssignCollection] = RougeMapInteractHelper.handleLossAssignCollection,
		[RougeMapEnum.InteractType.LossNotUniqueCollection] = RougeMapInteractHelper.handleLossNotUniqueCollection,
		[RougeMapEnum.InteractType.StorageCollection] = RougeMapInteractHelper.handleStorageCollection,
		[RougeMapEnum.InteractType.LossCoin] = RougeMapInteractHelper.handleLossCoin,
		[RougeMapEnum.InteractType.AdvanceDrop] = RougeMapInteractHelper.handleAdvanceDrop,
		[RougeMapEnum.InteractType.LevelUpSp] = RougeMapInteractHelper.handleLevelUpSpCollection,
		[RougeMapEnum.InteractType.LossSpCollection] = RougeMapInteractHelper.handleLossSpCollection,
		[RougeMapEnum.InteractType.DropBossCollection] = RougeMapInteractHelper.handleDropBossCollection
	}
end

function RougeMapInteractHelper.handleDrop(dropId)
	logWarn("触发掉落")

	local curInteractive = RougeMapModel.instance:getCurInteractiveJson()

	RougePopController.instance:addPopViewWithViewName(ViewName.RougeCollectionDropView, {
		viewEnum = RougeMapEnum.CollectionDropViewEnum.Select,
		collectionList = curInteractive.dropCollectList,
		canSelectCount = curInteractive.dropSelectNum,
		dropRandomNum = curInteractive.dropRandomNum
	})
end

function RougeMapInteractHelper.handleLoss()
	logWarn("触发丢弃")

	local curInteractive = RougeMapModel.instance:getCurInteractiveJson()
	local curInteractType = RougeMapModel.instance:getCurInteractType()

	RougePopController.instance:addPopViewWithViewName(ViewName.RougeMapCollectionAbandonView, {
		lossType = RougeMapEnum.LossType.Abandon,
		lostNum = curInteractive.lostNum,
		filterUnique = RougeMapHelper.checkNeedFilterUnique(curInteractType)
	})
end

function RougeMapInteractHelper.handleReturnBlood()
	logWarn("触发回血")

	local curInteractive = RougeMapModel.instance:getCurInteractiveJson()
	local viewParam = RougeController.instance:createTeamViewParam(curInteractive.healNum, RougeMapInteractHelper.onSelectReturnBloodHero)

	RougePopController.instance:addPopViewWithOpenFunc(ViewName.RougeTeamView, RougeController.openRougeTeamTreatView, RougeController.instance, viewParam)
end

function RougeMapInteractHelper.onSelectReturnBloodHero(obj, heroIdList)
	if not heroIdList or #heroIdList == 0 then
		return
	end

	RougeRpc.instance:sendRougeSelectHealRequest(heroIdList)
end

function RougeMapInteractHelper.handleRecruit()
	logWarn("触发招募")
	RougePopController.instance:addPopViewWithOpenFunc(ViewName.RougeHeroGroupEditView, RougeController.openSelectHero, RougeController.instance, RougeMapInteractHelper._selectHeroHandler)
end

function RougeMapInteractHelper._selectHeroHandler(obj, heroIdList)
	if not heroIdList or #heroIdList == 0 then
		RougeRpc.instance:sendRougeRecruitHeroRequest(nil)

		return
	end

	RougeRpc.instance:sendRougeRecruitHeroRequest(heroIdList)
end

function RougeMapInteractHelper.handleResurgence()
	logWarn("触发复活")

	local curInteractive = RougeMapModel.instance:getCurInteractiveJson()
	local viewParam = RougeController.instance:createTeamViewParam(curInteractive.reviveNum, RougeMapInteractHelper.onSelectReviveHero)

	RougePopController.instance:addPopViewWithOpenFunc(ViewName.RougeTeamView, RougeController.openRougeTeamReviveView, RougeController.instance, viewParam)
end

function RougeMapInteractHelper.onSelectReviveHero(obj, heroIdList)
	if not heroIdList or #heroIdList == 0 then
		return
	end

	RougeRpc.instance:sendRougeSelectReviveRequest(heroIdList)
end

function RougeMapInteractHelper.handleDropGroup()
	logWarn("触发掉落组")

	local curInteractive = RougeMapModel.instance:getCurInteractiveJson()

	RougePopController.instance:addPopViewWithViewName(ViewName.RougeCollectionDropView, {
		viewEnum = RougeMapEnum.CollectionDropViewEnum.Select,
		collectionList = curInteractive.dropCollectList,
		canSelectCount = curInteractive.dropSelectNum,
		dropRandomNum = curInteractive.dropRandomNum
	})
end

function RougeMapInteractHelper.handleLossAndCopy()
	logNormal("损失造物并复制")

	local curInteractive = RougeMapModel.instance:getCurInteractiveJson()
	local curInteractType = RougeMapModel.instance:getCurInteractType()

	RougePopController.instance:addPopViewWithViewName(ViewName.RougeMapCollectionAbandonView, {
		lossType = RougeMapEnum.LossType.Copy,
		lostNum = curInteractive.lostNum,
		filterUnique = RougeMapHelper.checkNeedFilterUnique(curInteractType)
	})
end

function RougeMapInteractHelper.handleLossAssignCollection()
	logNormal("损失指定造物")
end

function RougeMapInteractHelper.handleLossNotUniqueCollection()
	logNormal("损失非唯一造物")

	local curInteractive = RougeMapModel.instance:getCurInteractiveJson()
	local curInteractType = RougeMapModel.instance:getCurInteractType()

	RougePopController.instance:addPopViewWithViewName(ViewName.RougeMapCollectionAbandonView, {
		lossType = RougeMapEnum.LossType.Copy,
		lostNum = curInteractive.lostNum,
		filterUnique = RougeMapHelper.checkNeedFilterUnique(curInteractType)
	})
end

function RougeMapInteractHelper.handleStorageCollection()
	logNormal("存储造物")

	local curInteractive = RougeMapModel.instance:getCurInteractiveJson()

	RougePopController.instance:addPopViewWithViewName(ViewName.RougeMapCollectionStorageView, {
		lossCount = curInteractive.lostNum
	})
end

function RougeMapInteractHelper.handleLossCoin()
	logNormal("损失金币")
end

function RougeMapInteractHelper.handleAdvanceDrop(dropId)
	logNormal("高级掉落")

	local curInteractive = RougeMapModel.instance:getCurInteractiveJson()

	RougePopController.instance:addPopViewWithViewName(ViewName.RougeCollectionDropView, {
		viewEnum = RougeMapEnum.CollectionDropViewEnum.Select,
		collectionList = curInteractive.dropCollectList,
		canSelectCount = curInteractive.dropSelectNum,
		dropRandomNum = curInteractive.dropRandomNum
	})
end

function RougeMapInteractHelper.handleLevelUpSpCollection()
	logNormal("专武升级")

	local curInteractive = RougeMapModel.instance:getCurInteractiveJson()
	local curInteractType = RougeMapModel.instance:getCurInteractType()

	RougePopController.instance:addPopViewWithViewName(ViewName.RougeCollectionLevelUpView, {
		closeBtnVisible = false,
		maxLevelUpNum = curInteractive.collectionLevelUpNum,
		filterUnique = RougeMapHelper.checkNeedFilterUnique(curInteractType)
	})
end

function RougeMapInteractHelper.handleLossSpCollection(type)
	if type == 1 then
		logNormal("丢弃专武")

		local curInteractive = RougeMapModel.instance:getCurInteractiveJson()
		local curInteractType = RougeMapModel.instance:getCurInteractType()
		local collections = RougeDLCModel102.instance:getAllSpCollections()

		RougePopController.instance:addPopViewWithViewName(ViewName.RougeMapCollectionAbandonView, {
			lossType = RougeMapEnum.LossType.AbandonSp,
			lostNum = curInteractive.lostNum,
			filterUnique = RougeMapHelper.checkNeedFilterUnique(curInteractType),
			collections = collections
		})
	elseif type == 2 then
		logNormal("获得丢弃专武")
	end
end

function RougeMapInteractHelper.handleDropBossCollection()
	logNormal("选附带怪物属性的造物")

	local curInteractive = RougeMapModel.instance:getCurInteractiveJson()

	RougePopController.instance:addPopViewWithViewName(ViewName.RougeBossCollectionDropView, {
		viewEnum = RougeMapEnum.CollectionDropViewEnum.Select,
		canSelectCount = curInteractive.dropSelectNum,
		collectionList = curInteractive.dropCollectList,
		monsterRuleList = curInteractive.dropCollectMonsterRuleList
	})
end

return RougeMapInteractHelper
