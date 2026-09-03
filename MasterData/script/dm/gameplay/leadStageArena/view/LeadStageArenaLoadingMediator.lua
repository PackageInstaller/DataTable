-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/leadStageArena/view/LeadStageArenaLoadingMediator.lua

LeadStageArenaLoadingMediator = class("LeadStageArenaLoadingMediator", DmAreaViewMediator, _M)

function LeadStageArenaLoadingMediator:initialize()
	super.initialize(self)
end

function LeadStageArenaLoadingMediator:dispose()
	super.dispose(self)

	if self._timer then
		self._timer:stop()

		self._timer = nil
	end
end

function LeadStageArenaLoadingMediator:onRegister()
	super.onRegister(self)
end

function LeadStageArenaLoadingMediator:enterWithData(data)
	self._delegate = data.outself
	self._loadType = LoadingType.kLeadStageArena
	self._main = self:getView():getChildByName("main")
	self._bg = self._main:getChildByName("bg")
	self._tips1 = self._main:getChildByName("tips1")
	self._tips2 = self._main:getChildByName("tips2")
	self._loadingBar = self._main:getChildByFullName("content.bar")
	self._textPercent = self._main:getChildByFullName("content.text_hp_percent")
	self._textTitle = self._main:getChildByFullName("text_title")
	self._animNode = self._main:getChildByFullName("node_anim")

	local title_text = self._main:getChildByFullName("text_title")

	title_text:setString(Strings:get("StageArena_EntryLoading"))

	local loadingInfo = self:getLoadingData(self._loadType)
	local background = loadingInfo.Background
	local content = loadingInfo.Content
	local img, index = CommonUtils.randomByWeight(background.quanzhong, background.img)

	img = img or "qm_bg_bj.jpg"

	local tips, index = CommonUtils.randomByWeight(content.quanzhong, content.img)

	tips = tips or ""

	self._tips1:setString("Tips：")
	self._tips2:setString(Strings:get(tips))

	local bg = ccui.ImageView:create("asset/scene/" .. img)

	bg:addTo(self._bg):posite(0, 0)
	self._animNode:removeAllChildren()

	local anim = cc.MovieClip:create("zhu_jiubeiloading")

	anim:addTo(self._animNode)

	local loadingTime = loadingInfo.WaitingTime / 1000
	local startTime = app.getTime()

	local function update()
		local timeNow = app.getTime()

		if timeNow - startTime > loadingTime then
			self:close()
		end

		local p = math.modf((timeNow - startTime) / loadingTime * 100)

		self._loadingBar:setPercent(math.min(100, p))
		self._textPercent:setString(math.min(100, p) .. "%")
	end

	self._timer = LuaScheduler:getInstance():schedule(update, 0.01, false)
end

function LeadStageArenaLoadingMediator:getLoadingData(type)
	local d
	local lodinInfo = ConfigReader:getDataTable("Loading")

	for k, v in pairs(lodinInfo) do
		if v.Type == type then
			d = v

			break
		end
	end

	return d
end

function LeadStageArenaLoadingMediator:close()
	self:dismiss()

	if self._delegate:getLeadStageArenaSystem():getEnterErrorCode() == 1 then
		return
	end

	self._delegate:enterRivalViewNoReq()
end
