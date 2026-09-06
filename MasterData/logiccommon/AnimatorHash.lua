-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/avatar/animator/AnimatorHash.lua

module("logiccommon.common.avatar.animator.AnimatorHash", package.seeall)

local AnimatorHash = {
	escortLayer = "EscortLayer",
	maleBlendShapeName = "aoqinan_face",
	mountLayer = "MountLayer",
	femaleBlendShapeName = "aoqinv_face",
	animIdle = UnityEngine.Animator.StringToHash(MainPlayerAnimState.Idle),
	animWalk = UnityEngine.Animator.StringToHash(MainPlayerAnimState.Walk),
	animDig = UnityEngine.Animator.StringToHash(MainPlayerAnimState.Dig),
	animSearch = UnityEngine.Animator.StringToHash(MainPlayerAnimState.Search),
	animGreet = UnityEngine.Animator.StringToHash(MainPlayerAnimState.Greet),
	animUnlock = UnityEngine.Animator.StringToHash(MainPlayerAnimState.Unlock),
	animBandage = UnityEngine.Animator.StringToHash(MainPlayerAnimState.Bandage),
	animSalute = UnityEngine.Animator.StringToHash(MainPlayerAnimState.Salute),
	animChop = UnityEngine.Animator.StringToHash(MainPlayerAnimState.Chop),
	animPick = UnityEngine.Animator.StringToHash(MainPlayerAnimState.Pick),
	animBomb = UnityEngine.Animator.StringToHash(MainPlayerAnimState.Bomb),
	animDance = UnityEngine.Animator.StringToHash(MainPlayerAnimState.Dance),
	animSit = UnityEngine.Animator.StringToHash(MainPlayerAnimState.Sit),
	animCloths1041 = UnityEngine.Animator.StringToHash(MainPlayerAnimState.Cloths1041),
	animGreetFullPath = UnityEngine.Animator.StringToHash("Base Layer.greet"),
	animSalutePath = UnityEngine.Animator.StringToHash("Base Layer.salute"),
	animChopPath = UnityEngine.Animator.StringToHash("Base Layer.chop"),
	animUnlockPath = UnityEngine.Animator.StringToHash("Base Layer.unlock"),
	animPickPath = UnityEngine.Animator.StringToHash("Base Layer.pick"),
	animSitPath = UnityEngine.Animator.StringToHash("Base Layer.sit.situp"),
	animEat = UnityEngine.Animator.StringToHash(UnitAnimState.Eat),
	animTouch = UnityEngine.Animator.StringToHash(UnitAnimState.Touch)
}

function AnimatorHash.getAnimLength(animator, name)
	local length = 0.001
	local clips = animator.runtimeAnimatorController.animationClips

	for i = 0, clips.Length - 1 do
		local clip = clips[i]
		local sidx, eidx = string.find(clip.name, "@")
		local animName

		if (sidx and eidx and string.sub(clip.name, sidx + 1) or clip.name) == name then
			length = clip.length

			break
		end
	end

	return length
end

return AnimatorHash
