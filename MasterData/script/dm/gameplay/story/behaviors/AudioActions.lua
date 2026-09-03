-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/story/behaviors/AudioActions.lua

module("story", package.seeall)

PlayAudio = class("PlayAudio", BaseAction)

function PlayAudio:start(args)
	local actor = self:getActor()

	if actor then
		actor:play(args.isLoop)
	end

	return BehaviorResult.Success
end

function PlayAudio:abort(result)
	local actor = self:getActor()

	if actor then
		actor:stop(true)
	end

	super.abort(self, result)
end

StopAudio = class("StopAudio", BaseAction)

function StopAudio:start(args)
	local actor = self:getActor()

	if actor then
		actor:stop(args.isRelease)
	end

	return BehaviorResult.Success
end

PauseAudio = class("PauseAudio", BaseAction)

function PauseAudio:start(args)
	local actor = self:getActor()

	if actor then
		actor:pause()
	end

	return BehaviorResult.Success
end

ResumeAudio = class("ResumeAudio", BaseAction)

function ResumeAudio:start(args)
	local actor = self:getActor()

	if actor then
		actor:resume()
	end

	return BehaviorResult.Success
end

ElideAudio = class("ElideAudio", BaseAction)

function ElideAudio:start(args)
	local actor = self:getActor()

	if actor then
		actor:elide()
	end

	return BehaviorResult.Success
end

function ElideAudio:abort(result)
	local actor = self:getActor()

	if actor then
		actor:notElide()
	end

	super.abort(self, result)
end

NotElideAudio = class("NotElideAudio", BaseAction)

function NotElideAudio:start(args)
	local actor = self:getActor()

	if actor then
		actor:notElide()
	end

	return BehaviorResult.Success
end

BlockAudio = class("BlockAudio", BaseAction)

function BlockAudio:start(args)
	local actor = self:getActor()

	if actor then
		if args and args.blockId then
			actor:setBlock(args.blockId)
		else
			actor:setBlock()
		end
	end

	return BehaviorResult.Success
end

VolumeAudio = class("VolumeAudio", BaseAction)

function VolumeAudio:start(args)
	local actor = self:getActor()

	if actor and args and args.type and args.volumebegin >= 0 and args.volumeend >= 0 and args.duration then
		actor:volumeTo(args.type, args.volumebegin, args.volumeend, args.duration)
	end

	return BehaviorResult.Success
end

VolumeInAudio = class("VolumeInAudio", BaseAction)

function VolumeInAudio:start(args)
	local actor = self:getActor()

	if actor and args and args.type and args.duration then
		actor:volumeInAudio(args.type, args.duration, "in")
	end

	return BehaviorResult.Success
end

VolumeOutAudio = class("VolumeOutAudio", BaseAction)

function VolumeOutAudio:start(args)
	local actor = self:getActor()

	if actor and args and args.type and args.duration then
		actor:volumeInAudio(args.type, args.duration, "out")
	end

	return BehaviorResult.Success
end

VolumeOutAudioStop = class("VolumeOutAudioStop", BaseAction)

function VolumeOutAudioStop:start(args)
	local actor = self:getActor()

	if actor and args and args.type then
		actor:volumeOutAudioStop(args.type)
	end

	return BehaviorResult.Success
end
