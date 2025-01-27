enum OrderState {
  preparing,
  delivered,
  cancelled,
}

extension OrderStateX on String {
  OrderState toOrderState() {
    switch (toLowerCase()) {
      case 'delivered':
        return OrderState.delivered;
      case 'cancelled':
        return OrderState.cancelled;
      case 'preparing':
      default:
        return OrderState.preparing;
    }
  }
}
