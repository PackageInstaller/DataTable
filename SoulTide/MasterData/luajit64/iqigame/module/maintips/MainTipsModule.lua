-- chunkname: @IQIGame\\Module\\MainTips\\MainTipsModule.lua

MainTipsModule = {
	mainCfgTipsDataIDs = {}
}

function MainTipsModule.Init()
	EventDispatcher.AddEventListener(EventID.RedServerNotice, MainTipsModule.CheckMainTips)
	EventDispatcher.AddEventListener(EventID.UpdateItem, MainTipsModule.CheckSoulTips)
	EventDispatcher.AddEventListener(EventID.SoulUnlockSuccess, MainTipsModule.CheckSoulTips)
end

function MainTipsModule.Shutdown()
	EventDispatcher.RemoveEventListener(EventID.RedServerNotice, MainTipsModule.CheckMainTips)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, MainTipsModule.CheckSoulTips)
	EventDispatcher.RemoveEventListener(EventID.SoulUnlockSuccess, MainTipsModule.CheckSoulTips)
end

function MainTipsModule.CheckMainTips(type, show)
	if type == Constant.RedType.TYPE_TOWN then
		if show then
			MainTipsModule.AddTipsData(1)
		else
			MainTipsModule.RemoveTipsData(1)
		end
	end
end

function MainTipsModule.CheckSoulTips()
	local top = SoulModule.CheckExistCanUnlockSoul()

	if top == true then
		MainTipsModule.AddTipsData(2)
	else
		MainTipsModule.RemoveTipsData(2)
	end
end

function MainTipsModule.CheckTownNewStory()
	local top = MemoryNewModule.IsNewLockSoulStory()

	if top == true then
		MainTipsModule.AddTipsData(6)
	else
		MainTipsModule.RemoveTipsData(6)
	end

	EventDispatcher.Dispatch(EventID.RedServerNotice, Constant.RedType.TYPE_TOWN, top)
end

function MainTipsModule.AddTipsData(cid)
	if table.indexOf(MainTipsModule.mainCfgTipsDataIDs, cid) == -1 then
		table.insert(MainTipsModule.mainCfgTipsDataIDs, cid)
	end

	EventDispatcher.Dispatch(EventID.UpdateMainCityTips)
end

function MainTipsModule.RemoveTipsData(cid)
	local index = table.indexOf(MainTipsModule.mainCfgTipsDataIDs, cid)

	if index ~= -1 then
		table.remove(MainTipsModule.mainCfgTipsDataIDs, index)
	end

	EventDispatcher.Dispatch(EventID.UpdateMainCityTips)
end
