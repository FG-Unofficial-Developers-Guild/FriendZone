--
-- Please see the license.txt file included with this distribution for
-- attribution and copyright information.
--

local actionOriginal;

function onInit()
	actionOriginal = super.action;
	super.action = action;

	super.onInit();
end

function action(draginfo)
	local nSelection = getSelectionPosition();
	local nodeNPC = window.getDatabaseNode();
	if FriendZone.isCohort(nodeNPC) and nSelection and nSelection ~=0 then
		local sSelected = getValue():sub(getCursorPosition(), nSelection);
		local sMatch, sMultipliplier = sSelected:match("%+ ?(PB)[x%*]?(%d*)")
		if sMatch then
			local nMultiplier = tonumber(sMultipliplier);
			if not nMultiplier then
				nMultiplier = 1;
			end
			local nodeCommander = FriendZone.getCommanderNode(nodeNPC);
			local nProfBonus = DB.getValue(nodeCommander, "profbonus", 0);
			ActionSkillFZ.setCommanderProfBonus(nProfBonus * nMultiplier);
		end
	end
	actionOriginal(draginfo)
end
