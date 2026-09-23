
local itemPath = "UIs/Archive3/ArchiveRoleTCItem"
local selectIndex = nil
function Awake()
	layout = ComUtil.GetCom(vsv, "UIInfinite")
	--layout:AddBarAnim(0.4, false)
	layout:Init(itemPath, LayoutCallBack, true)
	tlua = UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.Normal)
	leftFade = ComUtil.GetCom(left, "ActionFade")
	CSAPI.SetGOActive(left, false)

	CSAPI.SetGOActive(animMask,false)
end

function LayoutCallBack(index)	
	local lua = layout:GetItemLua(index)
	if(lua) then
		local _data = curDatas[index]
		lua.SetIndex(index)
		lua.SetClickCB(SelectItemCB)
		lua.Refresh(_data, {data, selectIndex})
	end
end

function Refresh(_data, _selectSkin)
	data = _data
	curDatas = CRoleMgr:GetRoleScriptCfgs(data:GetID(), true)
	tlua:AnimAgain()
	AnimStart()
	layout:IEShowList(#curDatas,AnimEnd)
end

function SelectItemCB(item)
	-- RoleAudioPlayMgr:Play(item.cfg, function()
	-- 	PlayCB(item.index)
	-- end, EndCB)
	RoleAudioPlayMgr:StopSound()
	if(cardIconItem) then
		cardIconItem.PlayVoiceByID(item.cfg.id)
	end
end

function PlayCB(curCfg)
	if(not IsNil(gameObject)) then
		selectIndex = curCfg.id
		local cfgSound = Cfgs.Sound:GetByKey(curCfg.key)
		local script = SettingMgr:GetSoundScript(cfgSound) 
		if script then
			CSAPI.SetText(txtDesc, script)
			CSAPI.SetGOActive(left, true)
			leftFade.delayValue = 0	
			leftFade:Play(0, 1, 200)			
		end
		layout:UpdateList()
	end
end

function EndCB()
	if(not IsNil(gameObject)) then
		selectIndex = nil
		leftFade.delayValue = 1
		leftFade:Play(1, 0, 200, 0)
		layout:UpdateList()
	end
end

function AnimStart()
	CSAPI.SetGOActive(animMask,true)
end

function AnimEnd()
	CSAPI.SetGOActive(animMask,false)
end

function SetCardIconItem(_cardIconItem)
	cardIconItem = _cardIconItem
end 
function OnDestroy()    
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
vsv=nil;
left=nil;
txtDesc=nil;
view=nil;
end
----#End#----