-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityRiddleVoteMediator.lua

ActivityRiddleVoteMediator = class("ActivityRiddleVoteMediator", DmPopupViewMediator, _M)

function ActivityRiddleVoteMediator:initialize()
	super.initialize(self)
end

function ActivityRiddleVoteMediator:dispose()
	super.dispose(self)
end

function ActivityRiddleVoteMediator:onRegister()
	super.onRegister(self)
end

function ActivityRiddleVoteMediator:enterWithData(data)
	local data = data.data
	local main = self:getView():getChildByName("main")

	main:getChildByName("ratio1"):setString(Strings:get("Choice_Des_1") .. data.win .. "%")
	main:getChildByName("ratio2"):setString(Strings:get("Choice_Des_2") .. data.fail .. "%")
	main:getChildByName("LoadingBar_1"):setPercent(data.win)
end
