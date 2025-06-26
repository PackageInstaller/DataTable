-- chunkname: @IQIGame\\Scene\\Maze\\MazeScene.lua

local MazeBattleUIUserData = {}
local MazeScene = {
	isFirstEnterRoom = true
}

function MazeScene.CreateUserData(fightingHero)
	local obj = Clone(MazeBattleUIUserData)

	obj.fightingHero = fightingHero

	return obj
end

function MazeScene.New(callback, userData)
	local obj = Clone(MazeScene)

	obj:__OnInit(callback, userData)

	return obj
end

function MazeScene:__OnInit(callback, userData)
	self.completeCall = callback
	self.userData = userData

	self:__InitUI()
end

function MazeScene:__InitUI()
	self.isFirstEnterRoom = true

	function self.__delegateOnUILoaded(sender, args)
		self:__OnUILoaded(args)
	end

	function self.__delegateOnStartEnterMazeRoomComplete()
		self:__OnStartEnterMazeRoomComplete()
	end

	EventDispatcher.AddEventListener(EventID.StartEnterMazeRoomComplete, self.__delegateOnStartEnterMazeRoomComplete)
	GameEntry.LuaEvent:Subscribe(UIFreezeCompleteOnOpenEventArgs.EventId, self.__delegateOnUILoaded)
	UIModule.Open(Constant.UIControllerName.MazeBattleUI, Constant.UILayer.DefaultUI, self.userData)
end

function MazeScene:__OnUILoaded(args)
	if args.UIName ~= Constant.UIControllerName.MazeBattleUI then
		return
	end

	GameEntry.LuaEvent:Unsubscribe(UIFreezeCompleteOnOpenEventArgs.EventId, self.__delegateOnUILoaded)
end

function MazeScene:OnStartEnterRoom(stageMapPOD)
	self.curRoomCid = stageMapPOD.roomId

	EventDispatcher.Dispatch(EventID.StartEnterMazeRoom, stageMapPOD.roomId)
end

function MazeScene:__OnStartEnterMazeRoomComplete()
	if not self.isFirstEnterRoom then
		return
	end

	self.isFirstEnterRoom = false

	if self.completeCall ~= nil then
		self.completeCall()
	end
end

function MazeScene:OnEnterRoomFinish(stageMapPOD)
	EventDispatcher.Dispatch(EventID.EnterMazeRoomFinish, stageMapPOD.roomId)

	MazeModule.RoomIsEntering = false
end

function MazeScene:Dispose()
	UIModule.Close(Constant.UIControllerName.MazeBattleUI)
	EventDispatcher.RemoveEventListener(EventID.StartEnterMazeRoomComplete, self.__delegateOnStartEnterMazeRoomComplete)
	GameEntry.LuaEvent:Unsubscribe(UIFreezeCompleteOnOpenEventArgs.EventId, self.__delegateOnUILoaded)
end

return MazeScene
