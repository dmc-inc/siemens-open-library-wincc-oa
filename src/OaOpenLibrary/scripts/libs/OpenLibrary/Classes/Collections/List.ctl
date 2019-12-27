struct LinkedListNode
{
  anytype data;
  shared_ptr<LinkedListNode> next;
};

class ListIteratorClass
{
  private shared_ptr<LinkedListNode> node;

  public ListIteratorClass(shared_ptr<LinkedListNode> head)
  {
    this.node = head;
  }

  public bool hasNext()
  {
    return this.node != nullptr;
  }

  public anytype next()
  {
    if (this.hasNext())
    {
      anytype data = this.node.data;
      assignPtr(this.node, this.node.next);
      return data;
    }

    return nullptr;
  }
};

class ListClass
{
  private shared_ptr<LinkedListNode> head, tail;

  public ListClass()
  {
    this.head = nullptr;
    this.tail = nullptr;
  }

  public void add(anytype data)
  {
    shared_ptr<LinkedListNode> newNode = new LinkedListNode;
    newNode.data = data;
    newNode.next = nullptr;

    if (this.head == nullptr)
    {
      this.head = newNode;
    }
    else
    {
      this.tail.next = newNode;
    }

    assignPtr(this.tail, newNode);
  }

  public int size()
  {
    int size = 0;

    shared_ptr<LinkedListNode> temp = new LinkedListNode;
    temp = this.head;

    while (temp != nullptr)
    {
      size++;
      assignPtr(temp, temp.next);
    }

    return size;
  }

  public shared_ptr<ListIteratorClass> createIterator()
  {
    return new ListIteratorClass(this.head);
  }

  public void clear()
  {
    // Check if already empty
    if (this.head == nullptr)
    {
      return;
    }

    while (this.head != nullptr)
    {
      // Delete current head node
      shared_ptr<LinkedListNode> tempNode = new LinkedListNode;
      tempNode = this.head;
      this.head = this.head.next;
      tempNode = nullptr;
    }
  }
};
