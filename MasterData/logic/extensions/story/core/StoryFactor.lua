-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/StoryFactor.lua

module("logic.extensions.story.core.StoryFactor", package.seeall)

function CreateEvent(evtID)
	local cls = EventConfig[evtID]

	if cls then
		return cls:New()
	end

	return nil
end

function CreateSection(actionType)
	local config = FactoryConfig[actionType]

	if config and config.section then
		return config.section:New()
	end

	return nil
end

function CreateTrack(actionType)
	local config = FactoryConfig[actionType]

	if config and config.track then
		return config.track:New()
	end

	return DefaultStoryTrack.New()
end

FactoryConfig = {
	[StoryActionTypeEnum.Event] = {
		track = TrackEvent,
		section = SectionEvent
	},
	[StoryActionTypeEnum.Dialog] = {
		section = SectionDialog
	},
	[StoryActionTypeEnum.Branch] = {
		section = SectionBranch
	},
	[StoryActionTypeEnum.Video] = {
		section = SectionVideo
	},
	[StoryActionTypeEnum.SubCG] = {
		section = SectionSubCg
	},
	[StoryActionTypeEnum.Sound] = {
		section = SectionSound
	},
	[StoryActionTypeEnum.ParticleEffect] = {
		track = TrackParticleEffect,
		section = SectionParticleEffect
	},
	[StoryActionTypeEnum.TimeLine] = {
		track = TrackTimeLine,
		section = SectionTimeLine
	},
	[StoryActionTypeEnum.Animation] = {
		track = TrackGameObject,
		section = SectionAnimation
	},
	[StoryActionTypeEnum.Transform] = {
		track = TrackGameObject,
		section = SectionTransform
	},
	[StoryActionTypeEnum.Position] = {
		track = TrackGameObject,
		section = SectionPosition
	},
	[StoryActionTypeEnum.Rotation] = {
		track = TrackGameObject,
		section = SectionRotation
	},
	[StoryActionTypeEnum.Scale] = {
		track = TrackGameObject,
		section = SectionScale
	},
	[StoryActionTypeEnum.Move] = {
		track = TrackGameObject,
		section = SectionMove
	},
	[StoryActionTypeEnum.Visible] = {
		track = TrackGameObject,
		section = SectionVisible
	},
	[StoryActionTypeEnum.MoveDirection] = {
		track = TrackGameObject,
		section = SectionMoveDirection
	},
	[StoryActionTypeEnum.CharacterCamera] = {
		track = TrackCharacterCamera,
		section = SectionCharacterCamera
	},
	[StoryActionTypeEnum.RotationTo] = {
		track = TrackGameObject,
		section = SectionRotationTo
	},
	[StoryActionTypeEnum.ScaleTo] = {
		track = TrackGameObject,
		section = SectionScaleTo
	},
	[StoryActionTypeEnum.CameraMoveDirection] = {
		track = TrackGameObject,
		section = SectionCameraMoveDirection
	},
	[StoryActionTypeEnum.CharacterLookAt] = {
		track = TrackGameObject,
		section = SectionCharacterLookAt
	},
	[StoryActionTypeEnum.AnimationMouth] = {
		track = TrackGameObject,
		section = SectionAnimationMouth
	},
	[StoryActionTypeEnum.AnimationFace] = {
		track = TrackGameObject,
		section = SectionAnimationFace
	},
	[StoryActionTypeEnum.ShakeCamera] = {
		track = TrackGameObject,
		section = SectionShakeCamera
	},
	[StoryActionTypeEnum.AnimationHead] = {
		track = TrackGameObject,
		section = SectionAnimationHead
	}
}
EventConfig = {
	[EStoryEventIDType.Evt_BgMusicPlay] = EventBgMusicOpen,
	[EStoryEventIDType.Evt_BgMusicStop] = EventBgMusicClose,
	[EStoryEventIDType.Evt_ModelShowOpen] = EventModelShowOpen,
	[EStoryEventIDType.Evt_ModelShowClose] = EventModelShowClose,
	[EStoryEventIDType.Evt_Scene3DOpen] = EventScene3DOpen,
	[EStoryEventIDType.Evt_Scene3DClose] = EventScene3DClose,
	[EStoryEventIDType.Evt_UIFullEfxOpen] = EventUIFullEfxOpen,
	[EStoryEventIDType.Evt_UIFullEfxClose] = EventUIFullEfxClose,
	[EStoryEventIDType.Evt_SwitchCameraVisible] = EventSwitchCameraVisible,
	[EStoryEventIDType.Evt_FreeCamShow] = EventFreeCamShow,
	[EStoryEventIDType.Evt_FreeCamClose] = EventFreeCamClose,
	[EStoryEventIDType.Evt_AmbPlay] = EventAmbOpen,
	[EStoryEventIDType.Evt_AmbStop] = EventAmbClose,
	[EStoryEventIDType.Evt_SEPlay] = EventSEOpen,
	[EStoryEventIDType.Evt_Scene2DOpen] = EventScene2DOpen,
	[EStoryEventIDType.Evt_Scene2DClose] = EventScene2DClose,
	[EStoryEventIDType.Evt_SwitchLight] = EventSwitchLight,
	[EStoryEventIDType.Evt_SwitchDepthOfField] = EventSwitchDepthOfField,
	[EStoryEventIDType.Evt_2DPlaneFollowAndAim] = Event2DPlaneFollowAndAim,
	[EStoryEventIDType.Evt_SelectVolumeEffect] = EventSelectVolumeEffect,
	[EStoryEventIDType.Evt_Wink] = EventSelectWink,
	[EStoryEventIDType.Evt_SwitchXinMao] = EventSwitchXinMao,
	[EStoryEventIDType.Evt_Particle] = EventParticle,
	[EStoryEventIDType.Evt_LingGan] = EventLingGan
}
