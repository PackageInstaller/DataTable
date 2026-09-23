--队伍重命名
local inp;
function Awake()
    inp=ComUtil.GetCom(InputField,"InputField");
end

function OnOpen()
    UIUtil:ShowAction(root, nil, UIUtil.active2);
    if data then
        inp.text=data.name;
    end
end

function OnOk()
    Close();
end

function OnCancel()
    Close();
end

function OnClickMask()
    Close();
end

function Close()
    if data.onClose then
        data.onClose(inp.text);
    end
    UIUtil:HideAction(root, function()
        view:Close();
    end, UIUtil.active4);
end