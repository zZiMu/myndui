local B, C, L, DB = unpack(select(2, ...))
local cr, cg, cb = DB.ClassColor.r, DB.ClassColor.g, DB.ClassColor.b
if DB.Client ~= "zhCN" then return end

local hx = {
	"Aurora部分模块调整；",
	"更新部分法术监控；",
	"聊天窗口调整；",
	"团队框体更新对安托兰议会的载具支持；",
	"优化对不可打断的施法条的刷新；",
	"调整T21的团队法术监控。",
}

local function changelog()
	local f = CreateFrame("Frame", "NDuiChangeLog", UIParent)
	f:SetPoint("CENTER")
	f:SetScale(1.2)
	f:SetFrameStrata("HIGH")
	B.CreateMF(f)
	B.CreateBD(f)
	B.CreateTex(f)
	B.CreateFS(f, 30, "NDui", true, "TOPLEFT", 10, 25)
	B.CreateFS(f, 14, DB.Version, true, "TOPRIGHT", -10, 12)
	B.CreateFS(f, 16, L["Changelog"], true, "TOP", 0, -10)
	local ll = CreateFrame("Frame", nil, f)
	ll:SetPoint("TOP", -50, -35)
	B.CreateGF(ll, 100, 3, "Horizontal", cr, cg, cb, 0, .7)
	ll:SetFrameStrata("HIGH")
	local lr = CreateFrame("Frame", nil, f)
	lr:SetPoint("TOP", 50, -35)
	B.CreateGF(lr, 100, 3, "Horizontal", cr, cg, cb, .7, 0)
	lr:SetFrameStrata("HIGH")
	local offset = 0
	for n, t in pairs(hx) do
		B.CreateFS(f, 12, n.."："..t, false, "TOPLEFT", 15, -(50 + offset))
		offset = offset + 20
	end
	f:SetSize(400, 60 + offset)
	local close = B.CreateButton(f, 20, 20, "X")
	close:SetPoint("TOPRIGHT", -10, -10)
	close:SetScript("OnClick", function(self) f:Hide() end)
end

NDui:EventFrame("PLAYER_ENTERING_WORLD"):SetScript("OnEvent", function(self)
	self:UnregisterAllEvents()
	if HelloWorld then return end
	if not NDuiADB["Changelog"] then NDuiADB["Changelog"] = {} end

	local old1, old2, old3 = string.split(".", NDuiADB["Changelog"].Version or "")
	local cur1, cur2, cur3 = string.split(".", DB.Version)
	if old1 ~= cur1 or old2 ~= cur2 then
		changelog()
		NDuiADB["Changelog"].Version = DB.Version
	end
end)

SlashCmdList["NDUICHANGELOG"] = function()
	if not NDuiChangeLog then changelog() else NDuiChangeLog:Show() end
end
SLASH_NDUICHANGELOG1 = '/ncl'