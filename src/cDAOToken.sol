// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@thirdweb-dev/contracts/extension/PermissionsEnumerable.sol";
import "./ERC20Drop.sol";

contract cDAOToken is ERC20Drop, PermissionsEnumerable {
    /// @dev Only transfers to or from TRANSFER_ROLE holders are valid, when transfers are restricted.
    bytes32 private transferRole;

    constructor(string memory _name, string memory _symbol, address _primarySaleRecipient)
        ERC20Drop(_name, _symbol, _primarySaleRecipient)
    {
        bytes32 _transferRole = keccak256("TRANSFER_ROLE");

        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);

        // _setupRole(_transferRole, msg.sender);

        transferRole = _transferRole;
    }

    /// @dev Checks whether primary sale recipient can be set in the given execution context.
    function _canSetPrimarySaleRecipient() internal view override returns (bool) {
        return hasRole(DEFAULT_ADMIN_ROLE, _msgSender());
    }

    /// @dev Checks whether contract metadata can be set in the given execution context.
    function _canSetContractURI() internal view override returns (bool) {
        return hasRole(DEFAULT_ADMIN_ROLE, _msgSender());
    }

    /// @dev Checks whether platform fee info can be set in the given execution context.
    function _canSetClaimConditions() internal view override returns (bool) {
        return hasRole(DEFAULT_ADMIN_ROLE, _msgSender());
    }
}
